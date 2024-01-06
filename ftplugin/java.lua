-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

-- prints table
-- function printtable(table, indent)
--   print(tostring(table) .. '\n')
--   for index, value in pairs(table) do
--     print('    ' .. tostring(index) .. ' : ' .. tostring(value) .. '\n')
--   end
-- end

local bundles = {
  vim.fn.glob(
    "/Users/rsnhn/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
}

-- vim.list_extend(bundles, vim.split(vim.fn.glob("/Users/rsnhn/.local/share/nvim/mason/packages/java-test/extension/server/*.jar", false), "\n"))
vim.list_extend(bundles, vim.split(vim.fn.glob("/usr/local/share/vscode-java-test/server/*.jar", false), "\n"))
-- printtable(bundles)

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/Users/rsnhn/Projects/workspaces/' .. project_name

local jdtls_path = '/usr/local/opt/jdtls/libexec/'
local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
  cmd = {
    '/usr/bin/java', -- or '/path/to/java17_or_newer/bin/java'
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    "-javaagent:" .. "/Users/rsnhn/.m2/repository/org/projectlombok/lombok/1.18.30/lombok-1.18.30.jar",
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar', vim.fn.glob(jdtls_path .. 'plugins/org.eclipse.equinox.launcher_*.jar'),
    -- jdtls_path .. 'plugins/org.eclipse.equinox.launcher_1.6.600.v20231106-1826.jar',
    '-configuration', jdtls_path .. 'config_mac',

    '-data', workspace_dir
  },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  settings = {
    java = {
      signatureHelp = { enabled = true },
    },
    eclipse = {
      downloadSources = true,
    },
    maven = {
      downloadSources = true,
    },
    implementationsCodeLens = {
      enabled = true,
    },
    referencesCodeLens = {
      enabled = true,
    },
    references = {
      includeDecompiledSources = true,
    },
    inlayHints = {
      parameterNames = {
        enabled = "all", -- literals, all, none
      },
    },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    }
  },

  init_options = {
    bundles = bundles,
    extendedClientCapabilities = extendedClientCapabilities
  }
}

require('jdtls').setup_dap({ hotcodereplace = 'auto' })
require('jdtls').start_or_attach(config)
local nmap = function(keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { desc = desc })
  -- vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

-- See `:help K` for why this keymap
nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

-- Lesser used LSP functionality
nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
nmap('<leader>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, '[W]orkspace [L]ist Folders')

nmap('<leader>f', vim.lsp.buf.format, '[F]ormat document')
nmap('<leader>tn', vim.lsp.buf.format, '[F]ormat document')

vim.keymap.set("n", "<leader>tc", "<Cmd>lua require'jdtls'.test_class()<CR>", { desc = '[T]est [C]lass' })
vim.keymap.set("n", "<leader>tm", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>",
  { desc = '[T]est [N]earest method' })

vim.keymap.set('n', '<leader>jo', ':lua require("jdtls").organize_imports()<CR>', { silent = true })
vim.keymap.set({ "n", "v" }, '<leader>jv', ':lua require("jdtls").extract_variable()<CR>', { silent = true })
vim.keymap.set({ "n", "v" }, '<leader>jc', ':lua require("jdtls").extract_constant()<CR>', { silent = true })
vim.keymap.set('v', '<leader>jm', '<Esc>:lua require("jdtls").extract_method(true)<CR>', { silent = true })

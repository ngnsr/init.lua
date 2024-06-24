local options = {
  backup = false,                          -- creates a backup file
  clipboard = 'unnamedplus',               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  -- colorcolumn = '80',
  completeopt = { 'menuone', 'noselect' }, -- mostly just for cmp
  fileencoding = 'utf-8',                  -- the encoding written to a file
  hlsearch = false,                        -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  pumheight = 10,                          -- pop up menu height
  -- showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeout = true,                          --
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 50,                         -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 4,                          -- the number of spaces inserted for each indentation
  tabstop = 4,                             -- insert 4 spaces for a tab
  cursorline = false,                      -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 4 {default 2}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = true,                             -- display lines as one long line
  scrolloff = 10,                          -- is one of my fav
  sidescrolloff = 8,
  mouse = 'a',                             -- Enable mouse mode
  breakindent = true,                      -- Enable break indent
  autoindent = true,
  conceallevel = 1,                        -- needed for zathura
}

vim.opt.shortmess:append 'c'

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Set colorscheme
vim.o.termguicolors = true
-- vim.cmd [[colorscheme onedark]]

return {
  "iurimateus/luasnip-latex-snippets.nvim",
  dependencies = { 'L3MON4D3/LuaSnip', 'lervag/vimtex' },
  config = function()
    require 'luasnip-latex-snippets'.setup()
    -- or setup({ use_treesitter = true })
  end,
  -- treesitter is required for markdown
  ft = { "tex", "markdown" },

}

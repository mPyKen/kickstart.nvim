return {
  {
    'Exafunction/codeium.vim', -- note this is NOT codeium.nvim
    event = 'BufEnter',
  },
  {
    'Exafunction/codeium.nvim', -- note this is NOT codeium.vim
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = function()
      require('codeium').setup {}
    end,
  },
}

--- lua
-- vim.g.tabby_keybinding_accept = '<Tab>'
-- vim.g.tabby_keybinding_trigger_or_dismiss = '<C-\\>'

-- return {
--   {
--     'TabbyML/vim-tabby',
--   },
-- }

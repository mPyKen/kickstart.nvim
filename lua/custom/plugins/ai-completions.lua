return {
  {
    'Exafunction/codeium.vim', -- note this is NOT codeium.nvim
    event = 'BufEnter',
    config = function()
      vim.keymap.set('i', '<C-k>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-;>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-,>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<c-x>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true })
    end,
  },
  -- {
  --   'Exafunction/codeium.nvim', -- note this is NOT codeium.vim
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'hrsh7th/nvim-cmp',
  --   },
  --   config = function()
  --     require('codeium').setup {}
  --   end,
  -- },
}

--- lua
-- vim.g.tabby_keybinding_accept = '<Tab>'
-- vim.g.tabby_keybinding_trigger_or_dismiss = '<C-\\>'

-- return {
--   {
--     'TabbyML/vim-tabby',
--   },
-- }

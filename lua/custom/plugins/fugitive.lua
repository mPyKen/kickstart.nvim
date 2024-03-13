vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git Status (fugitive)' })
local PyKen_Fugitive = vim.api.nvim_create_augroup('PyKen_Fugitive', {})
local autocmd = vim.api.nvim_create_autocmd
autocmd('BufWinEnter', {
  group = PyKen_Fugitive,
  pattern = '*',
  callback = function()
    if vim.bo.ft ~= 'fugitive' then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set('n', '<leader>P', function()
      vim.cmd.Git 'push'
    end, vim.tbl_extend('force', opts, { desc = 'Git Push' }))

    -- rebase always
    vim.keymap.set('n', '<leader>p', function()
      vim.cmd.Git 'pull --rebase'
      -- vim.cmd.Git('pull')
    end, vim.tbl_extend('force', opts, { desc = 'Git Pull' }))

    -- NOTE: It allows me to easily set the branch i am pushing and any tracking
    -- needed if i did not set the branch up correctly
    -- vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
  end,
})

return {
  'tpope/vim-fugitive',
}

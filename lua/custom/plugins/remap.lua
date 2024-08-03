-- file explorer
vim.keymap.set('n', '<leader>ov', vim.cmd.Ex, { desc = 'Open netrw' })
vim.keymap.set('n', '<leader>ot', function()
  vim.cmd 'Neotree position=float reveal'
end, { desc = 'Open Neotree' })

-- wrapping
vim.keymap.set('n', '<leader>tw', ':set wrap!<CR>', { desc = 'Toggle Wrap' })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local move_lines = function(count, is_down)
  -- switch to normal mode
  local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
  vim.api.nvim_feedkeys(esc, 'x', false)

  local sel_end, mv_cmd = "'>", 'j'
  if not is_down then
    sel_end, mv_cmd = "'<", 'k'
  end

  -- get the number of lines to move relative to cursor position
  count = math.max(count, 1)
  local min_count = math.abs(vim.fn.line(sel_end) - vim.fn.line '.')
  if count <= min_count then
    count = count + min_count
  end

  -- get the number of lines to move relative to sel_end
  -- local cur_pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd('normal! ' .. tostring(count) .. mv_cmd)
  count = math.abs(vim.api.nvim_win_get_cursor(0)[1] - vim.fn.line(sel_end))
  -- vim.api.nvim_win_set_cursor(0, cur_pos)

  -- J: ":m '>+1<CR>gv=gv" K: ":m '<-2<CR>gv=gv"
  vim.cmd(":'<,'>m " .. sel_end .. tostring(is_down and count or -(count + 1)))
  vim.cmd 'normal! gv=gv'
end

vim.keymap.set('v', 'J', function()
  move_lines(vim.v.count, true)
end, { desc = 'Move selected lines down' })
vim.keymap.set('v', 'K', function()
  move_lines(vim.v.count, false)
end, { desc = 'Move selected lines up' })

vim.keymap.set('n', '<C-d>', 'M<C-d>zz')
vim.keymap.set('n', '<C-u>', 'M<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set({ 'n', 'x' }, '<leader>p', [["+p]], { desc = 'Paste from +' })
vim.keymap.set({ 'n', 'x' }, '<leader>P', [["+P]], { desc = 'Paste from +' })

-- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste without copy' })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Paste into +' })
vim.keymap.set('n', '<leader>Y', [["+y$]], { desc = 'Paste into +' })

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without copy' })

-- This is going to get me cancelled
vim.keymap.set('i', '<C-c>', '<Esc>', { remap = true })
-- vim.keymap.set('n', '<C-c>', '<Esc>', { remap = true })

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
-- vim.keymap.set('t', '<C-c>', [[<C-\><C-n>]])

return {}

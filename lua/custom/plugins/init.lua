local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

local PyKenGroup = augroup('PyKen', {})

function R(name)
  require('plenary.reload').reload_module(name)
end

command('Q', 'qa', {})

autocmd({ 'BufWritePre' }, {
  group = PyKenGroup,
  desc = 'Remove trailing white spaces before writing a buffer',
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

return {}

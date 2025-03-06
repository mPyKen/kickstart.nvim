local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

local PyKenGroup = augroup('PyKen', {})

function R(name)
  require("plenary.reload").reload_module(name)
end

local function write_session()
  if vim.fn.empty(vim.v.this_session) == 0 then
    vim.cmd("mks! " .. vim.v.this_session)
  end
end

command('Q', 'qa', {})

autocmd({ "VimLeave" }, {
  group = PyKenGroup,
  desc = "Save active sessions on exit",
  pattern = "*",
  callback = write_session,
})

autocmd({ "BufWritePre" }, {
  group = PyKenGroup,
  desc = "Remove trailing white spaces before writing a buffer",
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

return {}

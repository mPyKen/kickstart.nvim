local group = vim.api.nvim_create_augroup('PersistedHooks', {})

local tempshada = vim.fn.expand(vim.fn.stdpath 'cache' .. '/temp.shada')

vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'PersistedSavePost',
  group = group,
  callback = function(session)
    local session_path = vim.g.persisted_loaded_session
    if session_path == nil then
      return
    end
    local shada_path = vim.fn.expand(session_path .. '.shada')
    -- workaround: save to temp first as there is no official way to escape for cmd. then move file
    print('Saving shada ' .. shada_path)
    vim.cmd('wshada! ' .. tempshada)
    vim.fn.rename(tempshada, shada_path)
  end,
})

vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'PersistedLoadPost',
  group = group,
  callback = function(session)
    local session_path = vim.g.persisted_loaded_session
    if session_path == nil then
      return
    end
    local shada_path = vim.fn.expand(session_path .. '.shada')
    if vim.fn.filereadable(shada_path) == 1 then
      -- workaround: read & write = copy shada file, then read using rshada as there is no official way to escape for cmd
      print('Reading shada ' .. shada_path)
      local fl = vim.fn.readfile(shada_path, 'b')
      vim.fn.writefile(fl, tempshada, 'b')
      vim.cmd.rshada(tempshada)
    end
  end,
})

vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'PersistedTelescopeLoadPre',
  group = group,
  callback = function(session)
    -- Save the currently loaded session using a global variable
    require('persisted').save { session = vim.g.persisted_loaded_session }
    -- Delete all of the open buffers
    vim.api.nvim_input '<ESC>:%bd!<CR>'
  end,
})

return {
  {
    'olimorris/persisted.nvim',
    lazy = false, -- make sure the plugin is always loaded at startup
    config = function()
      require('persisted').setup {
        use_git_branch = true, -- create session files based on the branch of a git enabled repository
        default_branch = 'master',
        should_save = function()
          local bufname = vim.fn.expand '%:p' -- full path of current buffer
          local sn = vim.g.persisted_loaded_session
          return ((sn ~= nil and #sn > 0) or vim.fn.globpath(vim.fn.getcwd(), '.git') ~= '') and not bufname:find '/.git/'
        end,
        autoload = true, -- automatically load the session for the cwd on Neovim startup
        follow_cwd = false,
        telescope = {
          mappings = {
            -- change_branch = '<c-b>',
            copy_session = '<c-y>',
            -- delete_session = '<c-d>',
          },
        },
      }
      require('telescope').load_extension 'persisted'
    end,
  },
}

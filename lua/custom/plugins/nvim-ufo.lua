-- vim.o.foldcolumn = '1'
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- statuscol

vim.o.foldenable = true
vim.o.foldlevel = 99
vim.opt.foldlevelstart = -1

local winid = nil
vim.keymap.set('n', 'K', function()
  -- local floatwin = require 'ufo.preview.floatwin'
  -- print result of floatwin validate()

  local new_winid = require('ufo').peekFoldedLinesUnderCursor(false)
  if new_winid == winid then
    new_winid = require('ufo').peekFoldedLinesUnderCursor(true)
  end
  winid = new_winid
  if winid then
    local bufnr = vim.api.nvim_win_get_buf(winid)
    vim.keymap.set('n', '<C-c>', function()
      vim.api.nvim_win_close(winid, false)
    end, { noremap = false, buffer = bufnr })
  else
    vim.lsp.buf.hover()
  end
end)

return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  config = function()
    local ufo = require 'ufo'
    ufo.setup {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    }
    vim.keymap.set('n', 'zR', ufo.openAllFolds)
    vim.keymap.set('n', 'zM', ufo.closeAllFolds)
    vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
    vim.keymap.set('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
  end,
}

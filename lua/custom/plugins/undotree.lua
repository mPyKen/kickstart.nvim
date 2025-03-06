vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })

return {
  'mbbill/undotree',
  config = function()
    -- require("treesitter-context").setup({
    -- })
  end,
}

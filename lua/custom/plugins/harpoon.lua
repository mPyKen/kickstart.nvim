-- vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup({})
  end,
  keys = {
    { "<leader>N", function() require("harpoon"):list():append() end,  desc = "Add file to Harpoon list", },
    {
      "<leader>n",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Open Harpoon Quick Menu",
    },
    { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Select Harpoon item 1", },
    { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Select Harpoon item 2", },
    { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Select Harpoon item 3", },
    { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Select Harpoon item 4", },
    { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Select Harpoon item 5", },
  },
}

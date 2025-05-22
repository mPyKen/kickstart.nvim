-- vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    local extensions = require("harpoon.extensions")
    local path = require("plenary.path")
    harpoon:setup({})
    -- highlight current opened file
    harpoon:extend({
      [extensions.event_names.UI_CREATE] = function(ctx)
        local current = path:new(ctx.current_file):make_relative(vim.loop.cwd())
        local regex = "\\V\\^" .. current .. "\\$"
        -- highlight the line
        vim.api.nvim_set_hl(0, "HarpoonCurrentFile", { bg = "bg", fg = "fg" })
        vim.fn.clearmatches() -- vim.fn.matchdelete("HarpoonCurrentFile")
        vim.fn.matchadd("HarpoonCurrentFile", regex)
        -- move the cursor to the line
        vim.fn.search(regex)
      end,
    })
    -- clode menu with C-c
    harpoon:extend({
      [extensions.event_names.UI_CREATE] = function(ctx)
        vim.keymap.set("n", "<C-c>", function() harpoon.ui:close_menu() end, { buffer = ctx.bufnr })
      end,
    })
    -- harpoon:extend(extensions.builtins.navigate_with_number());
  end,
  keys = {
    { "<leader>N", function() require("harpoon"):list():add() end,  desc = "Add file to Harpoon list", },
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
    { "<leader>6", function() require("harpoon"):list():select(6) end, desc = "Select Harpoon item 6", },
    { "<leader>7", function() require("harpoon"):list():select(7) end, desc = "Select Harpoon item 7", },
    { "<leader>8", function() require("harpoon"):list():select(8) end, desc = "Select Harpoon item 8", },
    { "<leader>9", function() require("harpoon"):list():select(9) end, desc = "Select Harpoon item 9", },
    { "<leader>0", function() require("harpoon"):list():select(10) end, desc = "Select Harpoon item 10", },
  },
}

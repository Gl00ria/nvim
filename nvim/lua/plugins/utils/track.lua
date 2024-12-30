return {
  "dharmx/track.nvim",
  cmd = {
    "Mark",
    "Unmark",
    "Track",
    "MarkOpened",
    "SelectMark",
    "StashBundle",
    "RestoreBundle",
    "DeleteBundle",
    "AlternateBundle",
  },
  keys = {
    { "<leader>mm", "<cmd>Track views<cr>", desc = "View Marked Files 󰈈  " },
    { "<leader>mf", "<cmd>Mark<cr>", desc = "Mark File  " },
    { "<leader>mo", "<cmd>MarkOpened<cr>", desc = "Mark Opened Files   " },
    { "<leader>mu", "<cmd>Unmark<cr>", desc = "Unmark File  " },
  },
  opts = {
    save_path = vim.fn.expand("$HOME") .. "/.custom_db/nvim/plugins/track/track.json",
    root_path = false,
    disable_history = true, -- save deleted marks
    maximum_history = 20, -- limit history
    border = "rounded",
    width = 60,
    height = 10,
    title_pos = "left", -- row and col will be overridden
    exclude = {
      ["^%.git/.*$"] = false,
      ["^%.git$"] = false,
      ["^LICENSE$"] = false,
    },
    pickers = {
      views = {
        attach_mappings = function(_, map)
          local actions = require("telescope.actions") -- telescope builtin
          map("n", "q", actions.close)
          map("n", "v", actions.select_all)

          local track_actions = require("telescope._extensions.track.actions") -- track.nvim builtin
          map("n", "D", actions.select_all + track_actions.delete_view)
          map("n", "dd", track_actions.delete_view)
          map("n", "s", track_actions.change_mark_view)
          map("n", "<C-b>", track_actions.delete_buffer)
          map("n", "<C-j>", track_actions.move_view_next)
          map("n", "<C-k>", track_actions.move_view_previous)
          return true -- compulsory
        end,
      },
    },
  },
}

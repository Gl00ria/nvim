return {
  "Hashino/doing.nvim",
  config = function()
    require("doing").setup {
      message_timeout = 2000,
      doing_prefix = "Doing: ",

      ignored_buffers = { "NvimTree" },
      winbar = { enabled = true },

      store = {
        file_name = ".tasks_progress",
        auto_create_file = false,
      },
    }
    local api = require("doing.api")

    vim.keymap.set("n", "<leader>dk", "<cmd>Do!<cr>", { desc = "Add a task to the end of the list" })
    vim.keymap.set("n", "<leader>dj", "<cmd>Do<cr>", { desc = "Add a task to the front of the list" })
    vim.keymap.set("n", "<leader>de", api.edit, { desc = "[E]dit what tasks you`re [D]oing" })
    vim.keymap.set("n", "<leader>dn", api.done, { desc = "[D]o[n]e with current task" })
  end,
}

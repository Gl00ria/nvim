return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    -- TODO: keymap
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { "<leader>ts", "<cmd>SessionSearch<CR>", desc = "Session search" },
    -- { "<leader>tss", "<cmd>SessionSave<CR>", desc = "Save session" },
    -- { "<leader>wa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
  },
  opts = {
    enabled = true, -- Enables/disables auto creating, saving and restoring
    root_dir = vim.fn.expand("~") .. "/.custom_db/nvim/plugins/auto_session",
    auto_save = true, -- Enables/disables auto saving session on exit
    auto_restore = true, -- Enables/disables auto restoring session on start
    auto_create = false, -- Enables/disables auto creating new session files. Can take a function that should return true/false if a new session file should be created or not
    lazy_support = true, -- Automatically detect if Lazy.nvim is being used and wait until Lazy is done to make sure session is restored correctly. Does nothing if Lazy isn't being used. Can be disabled if a problem is suspected or for debugging
    session_lens = {
      load_on_setup = true, -- Initialize on startup (requires Telescope)
      theme_conf = { -- Pass through for Telescope theme options
        layout_config = { -- As one example, can change width/height of picker
          -- width = 0.8, -- percent of window
          -- height = 0.5,
        },
      },
      previewer = false, -- File preview for session picker

      mappings = {
        -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
        delete_session = { "i", "<C-D>" },
        alternate_session = { "i", "<C-S>" },
        copy_session = { "i", "<C-Y>" },
      },

      session_control = {
        root_dir = vim.fn.expand("~") .. "/.custom_db/nvim/plugins/auto_session",
        control_filename = "session_control.json", -- File name of the session control file
      },
    },
  },
}

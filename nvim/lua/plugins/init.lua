return {
  {
    "LazyVim/LazyVim",
    opts = {
      defaults = {
        autocmds = true, -- lazyvim.config.autocmds
        keymaps = false, -- lazyvim.config.keymaps
        options = true, -- lazyvim.config.options
      },
      news = {
        lazyvim = true,
        neovim = true,
      },
    },
  },
  -- require("plugins.utils"),
  -- require("plugins.coding"),
}

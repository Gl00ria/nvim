local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- themes plugins
    { import = "Gl0riVim.plugins.themes" },

    -- Warn: order matters
    -- coding plugins
    { import = "Gl0riVim.plugins.coding.treesitter" },
    { import = "Gl0riVim.plugins.coding.lsp" },
    { import = "Gl0riVim.plugins.coding.formatters_linters" },
    { import = "Gl0riVim.plugins.coding.lsp.langs" },
    { import = "Gl0riVim.plugins.coding" },

    -- editor plugins
    { import = "Gl0riVim.plugins.editor" },

    -- ui plugins
    { import = "Gl0riVim.plugins.ui" },

    -- utils plugins
    { import = "Gl0riVim.plugins.utils" },

    -- games plugins
    { import = "Gl0riVim.plugins.games" },
  },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = {
    colorscheme = { "habamax" },
    missing = true,
  },
  ui = {
    -- size = { width = 0.8, height = 0.6 },
    border = "rounded",
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = "󰈠 ",
      keys = "󰌌 ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = "󰏖 ",
      runtime = "󰕷 ",
      require = "󰢱 ",
      source = " ",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  debug = false,
})

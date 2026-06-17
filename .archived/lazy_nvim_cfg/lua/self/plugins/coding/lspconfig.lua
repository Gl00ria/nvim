return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      bashls = {},
    },
    setup = {
      filetypes = { "sh", "zsh" }, -- explicitly add zsh if you want
      cmd = { "bash-language-server", "start" },
    },
  },
}

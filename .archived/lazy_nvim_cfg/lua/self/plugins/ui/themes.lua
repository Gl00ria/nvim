return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- gruvbox,
      --
      -- rose-pine
      -- rose-pine-moon
      -- tokyonight
      colorscheme = "rose-pine-moon",
    },
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = {
          transparency = true,
        },
      })
    end,
  },

  "folke/tokyonight.nvim",
  "ellisonleao/gruvbox.nvim",
}

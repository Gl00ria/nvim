return {
  cmd = "",
  "rafamadriz/neon",
  config = function()
    vim.g.neon_style = "default" -- Available: default | doom | dark | light
    vim.g.neon_transparent = false
    vim.g.neon_italic_keyword = true
    vim.g.neon_italic_function = true
  end,
}

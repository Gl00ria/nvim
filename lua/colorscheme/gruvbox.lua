vim.g.gruvbox_contrast_dark = "dark"
vim.g.gruvbox_italic_comments = 1


local colorscheme = "gruvbox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

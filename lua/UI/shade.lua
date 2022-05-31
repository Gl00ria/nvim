-- use a protected call so we don't error out on first use
local status_ok, shade = pcall(require, "shade")
if not status_ok then
  return
end
shade.setup({
  overlay_opacity = 50,
  opacity_step = 1,
  keys = {
    brightness_up    = '<C-8>',
    brightness_down  = '<C-5>',
    toggle           = '<Leader>2',
  }
})

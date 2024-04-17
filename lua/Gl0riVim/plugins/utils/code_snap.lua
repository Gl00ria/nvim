local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (code_snap.lua)", vim.log.levels.WARN)
  return
end

local cs_opts = settings.utils_plugins.code_snap

local cs = {}

if cs_opts.enable then
  cs = {
    "mistricky/codesnap.nvim",
    build = "make",
    cmd = cs_opts.cmd,
    opts = {
      code_font_family = cs_opts.code_font_family,
      save_path = cs_opts.save_path,
      parsed = cs_opts.parsed,
      bg_theme = cs_opts.bg_theme,
      has_breadcrumbs = cs_opts.has_breadcrumbs,
      breadcrumbs_separator = cs_opts.breadcrumbs_separator,
      watermark_font_family = cs_opts.watermark_font_family,
      watermark = cs_opts.watermark,
    },
  }
end

return cs

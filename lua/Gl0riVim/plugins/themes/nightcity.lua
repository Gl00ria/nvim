local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (nightcity.lua)", vim.log.levels.WARN)
  return
end

local nightcity_opts = settings.theme_plugins.nightcity

local nightcity = {}

if nightcity_opts.enable then
  nightcity = {
    cmd = "",
    "cryptomilk/nightcity.nvim",
    opts = {
      -- kabuki or afterlife
      style = nightcity_opts.style, -- kabuki | afterlife
      terminal_colors = true, -- Use colors used when opening a `:terminal`
      invert_colors = {
        -- Invert colors for the following syntax groups
        cursor = true,
        diff = true,
        error = true,
        search = true,
        selection = false,
        signs = false,
        statusline = true,
        tabline = false,
      },
      font_style = {
        -- Style to be applied to different syntax groups
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        search = { bold = true },
      },
      -- Plugin integrations. Use `default = false` to disable all integrations.
      plugins = { default = true },
      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      on_highlights = function(groups, colors) end,
    },
  }
end

return nightcity

local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (weather.lua)", vim.log.levels.WARN)
  return
end

local weather_opts = settings.utils_plugins.weather
local weather = {}

if weather_opts.enable then
  weather = {
    "lazymaniac/wttr.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      location = "",
      format = 1,
      -- Possible options:
      --     c  # Weather condition,
      --     C  # Weather condition textual name,
      --     x  # Weather condition, plain-text symbol,
      --     h  # Humidity,
      --     f  # Temperature (Feels Like),
      --     w  # Wind,
      --     l  # Location,
      --     m  # Moon phase 🌑🌒🌓🌔🌕🌖🌗🌘,
      --     M  # Moon day,
      --     p  # Precipitation (mm/3 hours),
      --     P  # Pressure (hPa),
      --     u  # UV index (1-12),
      --     D  # Dawn*,
      --     S  # Sunrise*,
      --     z  # Zenith*,
      --     s  # Sunset*,
      --     d  # Dusk*,
      --     T  # Current time*,
      --     Z  # Local timezone.
      custom_format = weather_opts.custom_format,
    },
  }
end

return weather

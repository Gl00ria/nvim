local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (ccc.lua)", vim.log.levels.WARN)
  return
end

local color_picker_opts = settings.utils_plugins.color_picker

local color_picker = {}

if color_picker_opts.enable then
  color_picker = {
    "uga-rosa/ccc.nvim",
    cmd = color_picker_opts.cmd,
    keys = color_picker_opts.keys,
    config = function()
      if vim.version().minor < 8 then
        vim.notify("Plugin [ccc] requires 0.8 or higher", vim.log.levels.WARN)
        return
      end

      -- use a protected call so we don't error out on first use
      local status_ok, ccc = pcall(require, "ccc")
      if not status_ok then
        vim.notify("Plugin [CCC] failed to load", vim.log.levels.WARN)
        return
      end

      ccc.setup({
        default_color = "#000000",
        highlight_mode = "bg", -- fg || bg
        bar_len = 50,
        bar_char = "",

        point_char = "󱞪 ",
        point_color = "#FF0000",

        win_opts = {
          relative = "cursor",
          row = 1,
          col = 1,
          style = "minimal",
          border = "shadow", -- rounded, single, none, double, shadow
        },

        -- auto_close = true,
        -- preserve = true, -- start when you left off last time

        inputs = {
          -- default
          ccc.input.rgb,
          ccc.input.hsl,
          ccc.input.cmyk,

          ccc.input.hwb,
          ccc.input.lab,
          ccc.input.lch,
          ccc.input.oklab,
          ccc.input.oklch,
          ccc.input.hsluv,
          ccc.input.okhsl,
          ccc.input.hsv,
          ccc.input.okhsv,
          ccc.input.xyz,
        },

        outputs = {
          -- default
          ccc.output.hex, -- HEX (6/8 digits)
          ccc.output.hex_short, -- HEX (3/4 digits)
          ccc.output.css_rgb,
          ccc.output.css_hsl,

          ccc.output.css_hwb,
          ccc.output.css_lab,
          ccc.output.css_lch,
          ccc.output.css_oklab,
          ccc.output.css_oklch,
          ccc.output.float,
        },

        pickers = {
          -- default
          ccc.picker.hex,
          ccc.picker.css_rgb,
          ccc.picker.css_hsl,
          ccc.picker.css_hwb,
          ccc.picker.css_lab,
          ccc.picker.css_lch,
          ccc.picker.css_oklab,
          ccc.picker.css_oklch,

          ccc.picker.css_oklab,
          ccc.picker.css_oklch,
          ccc.picker.css_name,
        },

        convert = {
          { ccc.picker.hex, ccc.output.css_rgb },
          { ccc.picker.css_rgb, ccc.output.css_hsl },
          { ccc.picker.css_hsl, ccc.output.hex },
        },

        disable_default_mappings = false,
      })
    end,
  }
end
return color_picker

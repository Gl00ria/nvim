local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (juliana.lua)", vim.log.levels.WARN)
  return
end

local juliana = {}

if settings.theme_plugins.juliana.enable then
  juliana = {
    cmd = "",
    "kaiuri/nvim-juliana",
    config = function()
      if vim.version().minor < 10 then
        vim.notify("Plugin [Juliana] requires 0.10 or higher", vim.log.levels.WARN)
        return
      end
      -- local gruvbox = function(mode)
      --   local function pick(tbl)
      --     return tbl[mode]
      --   end
      --   return {
      --     bg1 = pick({ light = "#fff7d5", dark = "#32302e" }),
      --     bg2 = pick({ light = "#fff5cb", dark = "#282828" }),
      --     bg3 = pick({ light = "#fff2bc", dark = "#242424" }),
      --     blue1 = pick({ light = "#076578", dark = "#83a598" }),
      --     blue2 = pick({ light = "#074f78", dark = "#458588" }),
      --     cyan1 = pick({ light = "#689d69", dark = "#8ec07c" }),
      --     cyan2 = pick({ light = "#23693e", dark = "#689d6a" }),
      --     diff_add = pick({ light = "#c7d4c4", dark = "#343427" }),
      --     diff_change = pick({ light = "#eadba9", dark = "#3e3428" }),
      --     diff_remove = pick({ light = "#eac4a9", dark = "#3c2828" }),
      --     diff_text = pick({ light = "#ffe789", dark = "#32302e" }),
      --     fg1 = pick({ light = "#282828", dark = "#fff5cb" }),
      --     fg2 = pick({ light = "#353535", dark = "#ebdbb2" }),
      --     fg3 = pick({ light = "#797467", dark = "#928374" }),
      --     fg4 = pick({ light = "#938e80", dark = "#665c54" }),
      --     green = pick({ light = "#228b22", dark = "#a8a920" }),
      --     magenta = pick({ light = "#8f3f71", dark = "#c2748f" }),
      --     orange = pick({ light = "#f71d05", dark = "#fb4834" }),
      --     red1 = pick({ light = "#cc241d", dark = "#d44333" }),
      --     red2 = pick({ light = "#9d0006", dark = "#cc231d" }),
      --     selection_bg = pick({ light = "#ffeda3", dark = "#423d39" }),
      --     text_fg = pick({ light = "#282828", dark = "#eadbb5" }),
      --     yellow1 = pick({ light = "#cba200", dark = "#fabd2f" }),
      --     yellow2 = pick({ light = "#ab7b1a", dark = "#e8ab28" }),
      --     yellow3 = pick({ light = "#996814", dark = "#d79a21" }),
      --   }
      -- end

      -- require("nvim-juliana").setup({ colors = gruvbox("dark") })
    end,
  }
end

return juliana

-- Credits: https://www.lazyvim.org/extras/util/dot
local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (hypr.lua)", vim.log.levels.WARN)
  return
end

local hypr = {}

if settings.langs_control.hypr.enable then
  hypr = {
    {
      event = settings.langs_control.hypr.event,
      "luckasRanarison/tree-sitter-hypr",
      build = ":TSUpdate hypr",
      config = function()
        -- fix ft detection for hyprland
        vim.filetype.add({
          pattern = { [".*/hyprland%.conf"] = "hyprlang" },
        })
        require("nvim-treesitter.parsers").get_parser_configs().hyprlang = {
          install_info = {
            url = "https://github.com/luckasRanarison/tree-sitter-hyprlang",
            files = { "src/parser.c" },
            branch = "master",
          },
          filetype = "hyprlang",
        }
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        local function add(lang)
          if type(opts.ensure_installed) == "table" then
            table.insert(opts.ensure_installed, "hyprlang")
          end
        end

        vim.filetype.add({
          extension = { rasi = "rasi" },
          pattern = {
            [".*/waybar/config"] = "jsonc",
            [".*/mako/config"] = "dosini",
            [".*/kitty/*.conf"] = "bash",
          },
        })
        add("git_config")
      end,
    },
  }
end

return hypr

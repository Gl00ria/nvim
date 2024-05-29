-- credits: (https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/util/dot.lua)
local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (dots.lua)", vim.log.levels.WARN)
  return
end

local treesitter_opts = settings.coding_plugins.treesitter

local treesitter = {}

local xdg_config = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"
local function have(path)
  return vim.uv.fs_stat(xdg_config .. "/" .. path) ~= nil
end
if treesitter_opts.enable then
  treesitter = {
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        local function add(lang)
          if type(opts.ensure_installed) == "table" then
            table.insert(opts.ensure_installed, lang)
          end
        end

        vim.filetype.add({
          extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
          filename = {
            ["vifmrc"] = "vim",
          },
          pattern = {
            [".*/waybar/config"] = "jsonc",
            [".*/mako/config"] = "dosini",
            [".*/kitty/.+%.conf"] = "bash",
            [".*/hypr/.+%.conf"] = "hyprlang",
            ["%.env%.[%w_.-]+"] = "sh",
          },
        })

        add("git_config")

        if have("hypr") then
          add("hyprlang")
        end

        if have("fish") then
          add("fish")
        end

        if have("rofi") or have("wofi") then
          add("rasi")
        end
      end,
    },
  }
end

return treesitter

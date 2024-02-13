local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (lualine.lua)", vim.log.levels.WARN)
  return
end

local lualine_opts = settings.ui_plugins.lauline
local lualine = {}

local custom_fun_status, custom_fun = pcall(require, "Gl0riVim.config.utils")
if not custom_fun_status then
  vim.notify("[functions] failed to load within (lualine.lua)", vim.log.levels.WARN)
  return
end

local function maximize_status()
  return vim.t["maximized"] and " " or ""
end

if lualine_opts.enable then
  lualine = {
    "nvim-lualine/lualine.nvim",
    event = lualine_opts.event,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "meuter/lualine-so-fancy.nvim" },
    },
    init = function()
      local lualine_aug = vim.api.nvim_create_augroup("StatusLineWatchRecording", { clear = true })
      local function refresh_lualine_callback()
        require("lualine").refresh({ place = { "statusline" } })
      end
      vim.api.nvim_create_autocmd("RecordingEnter", {
        group = lualine_aug,
        callback = refresh_lualine_callback,
      })
      vim.api.nvim_create_autocmd("RecordingLeave", {
        group = lualine_aug,
        callback = function()
          local timer = vim.loop.new_timer()
          if timer ~= nil then
            timer:start(50, 0, vim.schedule_wrap(refresh_lualine_callback))
          end
        end,
      })
    end,
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "█", right = "█" },
        -- separator = { left = " ", right = " " }
        -- section_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        -- separator = { left = " ", right = "" },
        -- separator = { left = "", right = "" },
        -- separator = { left = "█", right = "█" },
        disabled_filetypes = { "toggleterm" },
        globalstatus = true,
        always_divide_middle = false,
      },
      sections = {
        lualine_a = {
          { "fancy_mode", width = 6 },
        },
        lualine_b = {
          { "branch" },
          { "fancy_diff" },
          { "fancy_diagnostics" },
        },
        lualine_c = {
          -- { "fancy_cwd", substitute_home = true },
          -- { "filename", path = 1 },
          {
            "maximized-status",
            fmt = maximize_status,
          },
        },
        lualine_x = {
          { "fancy_macro", icon = { " ", color = "WarningMsg" } },
          { "fancy_searchcount", icon = { " ", color = { fg = "#FCBA03" } } },
        },
        lualine_y = {
          { "fancy_filetype", ts_icon = "" },
          -- { "fancy_lsp_servers", icon = { "", color = { fg = "#FFFF00" } } },
          {
            -- Lsp server name .
            function()
              local msg = "No Active Lsp"
              local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
              local clients = vim.lsp.get_active_clients()
              if next(clients) == nil then
                return msg
              end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name
                end
              end
              return msg
            end,
            -- icon = "  LSP:",
            icon = { "  :", color = { fg = "#FFFF00" } },
          },
          {
            custom_fun.py_vertual_env,
            color = { fg = "#98be65" },
            cond = custom_fun.hide_in_width,
          },
        },
        lualine_z = {
          { "selectioncount" },
          {
            "fileformat",
            symbols = { unix = "󰣇", dos = "", mac = "" },
          },
          { "encoding" },
          { custom_fun.progress },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        -- lualine_x = { custom_fun.progress },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    },
  }
end

return lualine

-----------------------------------------------------------------------

-- "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     -- event = "VimEnter",
--     -- init = function()
--     --   vim.g.lualine_laststatus = vim.o.laststatus
--     --   if vim.fn.argc(-1) > 0 then
--     --     -- set an empty statusline till lualine loads
--     --     vim.o.statusline = " "
--     --   else
--     --     -- hide the statusline on the starter page
--     --     vim.o.laststatus = 0
--     --   end
--     -- end,
--     config = function()
--       -- minimum requirements for this plugin
--       if vim.version().minor < 5 then
--         vim.notify("Plugin [lualine] requires 0.5 or higher", vim.log.levels.WARN)
--         return
--       end

--       local status_ok, lualine_ = pcall(require, "lualine")
--       if not status_ok then
--         vim.notify("Plugin [lualine] failed to load", vim.log.levels.WARN)
--         return
--       end
--       local icon_status, icons = pcall(require, "icons")
--       if not icon_status then
--         vim.notify("[icons] failed to load within (lualine.lua)", vim.log.levels.WARN)
--         return
--       end

--       local custom_fun_status, custom_fun = pcall(require, "Gl0riVim.config.functions")
--       if not custom_fun_status then
--         vim.notify("[functions] failed to load within (lualine.lua)", vim.log.levels.WARN)
--         return
--       end

--       -- local pomodoro = require("pomodoro").statusline

--       -- Color table for highlights
--       local colors = {
--         bg = "#0F111A",
--         fg = "#bbc2cf",
--         yellow = "#E2D140",
--         cyan = "#066C77",
--         darkblue = "#0D387C",
--         green = "#598738",
--         orange = "#FF8800",
--         violet = "#a9a1e1",
--         magenta = "#c678dd",
--         blue = "#18416F",
--         red = "#782220",
--       }
--       local mode_color = {
--         n = colors.red,
--         i = colors.green,
--         v = colors.blue,
--         [""] = colors.blue,
--         V = colors.blue,
--         c = colors.magenta,
--         no = colors.red,
--         s = colors.orange,
--         S = colors.orange,
--         [""] = colors.orange,
--         ic = colors.yellow,
--         R = colors.violet,
--         Rv = colors.violet,
--         cv = colors.red,
--         ce = colors.red,
--         r = colors.cyan,
--         rm = colors.cyan,
--         ["r?"] = colors.cyan,
--         ["!"] = colors.red,
--         t = colors.red,
--       }
--       -- Config
--       local opts = {
--         options = {
--           -- Disable sections and component separators
--           component_separators = "",
--           section_separators = "",
--           theme = "auto",
--           -- theme = {
--           --   -- We are going to use lualine_c an lualine_x as left and
--           --   -- right section. Both are highlighted by c theme .  So we
--           --   -- are just setting default looks o statusline
--           --   normal = { c = { fg = colors.fg, bg = colors.bg } },
--           --   inactive = { c = { fg = colors.fg, bg = colors.bg } },
--           -- },
--         },
--         sections = {
--           -- these are to remove the defaults
--           lualine_a = {},
--           lualine_b = {},
--           lualine_y = {},
--           lualine_z = {},
--           -- These will be filled later
--           lualine_c = {},
--           lualine_x = {},
--         },
--         inactive_sections = {
--           -- these are to remove the defaults
--           lualine_a = {},
--           lualine_b = {},
--           lualine_y = {},
--           lualine_z = {},
--           lualine_c = {},
--           lualine_x = {},
--         },
--       }

--       -- Inserts a component in lualine_c at left section
--       local function ins_left(component)
--         table.insert(opts.sections.lualine_c, component)
--       end

--       -- Inserts a component in lualine_x at right section
--       local function ins_right(component)
--         table.insert(opts.sections.lualine_x, component)
--       end

--       --
--       --
--       --
--       --
--       --
--       --
--       -- Add components to left sections
--       --
--       --
--       --
--       --
--       --
--       --
--       -- ins_left({
--       --     function()
--       --         return "▊"
--       --     end,
--       --     color = { fg = colors.blue }, -- Sets highlighting of component
--       --     padding = { left = 0, right = 1 }, -- We don't need space before this
--       -- })
--       ins_left({
--         -- mode component
--         function()
--           -- local VMode = vim.fn.mode()
--           -- local VUpper = "--" .. string.upper(VMode) .. "--"
--           local VUpper = "  "
--           -- return "  " .. VUpper
--           return VUpper
--           -- return "󱓻"
--         end,
--         color = function()
--           -- auto change color according to neovims mode
--           return { fg = colors.bg, bg = mode_color[vim.fn.mode()] }
--         end,
--         padding = { left = 0, right = 0 },
--         -- separator = { left = " ", right = "" },
--         -- separator = { left = " ", right = " " }
--         -- separator = { left = "█", right = "█" },
--         separator = { left = "", right = "" },
--         -- separator = { left = "█", right = "█" },
--       })

--       ins_left({
--         "branch",
--         icon = "",
--         color = { fg = colors.violet, gui = "bold" },
--       })

--       ins_left({
--         "filesize",
--         icon = "",
--         cond = custom_fun.buffer_not_empty,
--         color = function()
--           -- auto change color according to neovims mode
--           -- return { fg = colors.bg, bg = mode_color[vim.fn.mode()] }
--           return { fg = mode_color[vim.fn.mode()] }
--         end,
--       })

--       ins_left({
--         function()
--           local ok, pomo = pcall(require, "pomo")
--           if not ok then
--             return ""
--           end

--           local timer = pomo.get_first_to_finish()
--           if timer == nil then
--             return ""
--           end

--           return "󰄉 " .. tostring(timer)
--         end,

--         -- pomodoro,
--         color = { fg = "#bc1c1c", gui = "bold" },
--       })

--       ins_left({
--         update_in_insert = false,
--         -- always_visible = true,
--         "diagnostics",
--         sources = { "nvim_diagnostic" },
--         sections = { "error", "warn", "hint", "info" },
--         symbols = {
--           error = icons.diagnostics.error .. " ",
--           warn = icons.diagnostics.Warn .. " ",
--           hint = icons.diagnostics.Hint .. " ",
--           info = icons.diagnostics.Information .. " ",
--         },
--         diagnostics_color = {
--           color_error = { fg = colors.red },
--           color_warn = { fg = colors.yellow },
--           color_hint = { fg = colors.blue },
--           color_info = { fg = colors.cyan },
--         },
--       })

--       ins_left({
--         -- Display number of loaded buffers
--         -- credits (https://github.com/al-ce/nvim/blob/fdc7aadf8a56f52dcf73d1c4e24c918c2efa9801/lua/plugins/plugins.lua#L1280)
--         function()
--           local is_loaded = vim.api.nvim_buf_is_loaded
--           local tbl = vim.api.nvim_list_bufs()
--           local loaded_bufs = 0
--           for i = 1, #tbl do
--             if is_loaded(tbl[i]) then
--               loaded_bufs = loaded_bufs + 1
--             end
--           end
--           return loaded_bufs
--         end,
--         icon = "﬘",
--         color = { fg = "DarkCyan", gui = "bold" },
--       })
--       -- Insert mid section. You can make any number of sections in neovim :)
--       -- for lualine it's any number greater then 2
--       ins_left({
--         function()
--           return "%="
--         end,
--       })

--       ins_left({
--         -- Lsp server name .
--         function()
--           local msg = "No Active Lsp"
--           local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
--           local clients = vim.lsp.get_active_clients()
--           if next(clients) == nil then
--             return msg
--           end
--           for _, client in ipairs(clients) do
--             local filetypes = client.config.filetypes
--             if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--               return client.name
--             end
--           end
--           return msg
--         end,
--         icon = " LSP:",
--         -- color = { fg = "#ffffff", gui = "bold" },
--         -- color = { fg = "#bc1c1c", gui = "bold" },
--         color = function()
--           -- auto change color according to neovims mode
--           return { fg = colors.bg, bg = mode_color[vim.fn.mode()] }
--           -- return { fg = mode_color[vim.fn.mode()] }
--         end,
--         -- separator = { left = " ", right = "" },
--         -- separator = { left = " ", right = " " }
--         -- separator = { left = "█", right = "█" },
--         separator = { left = "", right = "" },
--         -- separator = { left = "█", right = "█" },
--       })
--       ins_left({
--         custom_fun.py_vertual_env,
--         color = { fg = "#98be65" },
--         cond = custom_fun.hide_in_width,
--       })

--       --
--       --
--       --
--       --
--       --
--       --
--       -- Add components to right sections
--       --
--       --
--       --
--       --
--       --
--       --
--       ins_right({
--         "diff",
--         -- Is it me or the symbol for modified us really weird
--         -- symbols = { added = " ", modified = "󰝤 ", removed = " " },
--         symbols = { added = icons.git.Added, modified = icons.git.Modified, removed = icons.git.Removed },
--         diff_color = {
--           added = { fg = colors.green },
--           modified = { fg = colors.orange },
--           removed = { fg = colors.red },
--         },
--       })

--       ins_right({
--         "searchcount",
--         color = { fg = "#bc1c1c", gui = "bold" },
--       })

--       ins_right({
--         require("lazy.status").updates,
--         cond = require("lazy.status").has_updates,
--         color = { fg = "DarkCyan", gui = "bold" },
--       })

--       ins_right({
--         "fileformat",
--         color = function()
--           -- auto change color according to neovims mode
--           -- return { fg = colors.bg, bg = mode_color[vim.fn.mode()] }
--           return { fg = mode_color[vim.fn.mode()] }
--         end,
--         symbols = { unix = "󰣇", dos = "", mac = "" },
--       })

--       ins_right({
--         custom_fun.time,
--         color = { fg = "#bc1c1c", gui = "bold" },
--       })

--       ins_right({
--         custom_fun.progress,
--         color = function()
--           -- auto change color according to neovims mode
--           return { fg = colors.bg, bg = mode_color[vim.fn.mode()] }
--         end,
--         -- separator = { left = " ", right = "" },
--         -- separator = { left = " ", right = " " }
--         -- separator = { left = "█", right = "█" },
--         separator = { left = "", right = "" },
--         -- separator = { left = "█", right = "█" },
--       })

--       -- ins_right({
--       --     function()
--       --         return "▊"
--       --     end,
--       --     color = { fg = colors.blue },
--       --     padding = { left = 1 },
--       -- })

--       -- Now don't forget to initialize lualine
--       lualine_.setup(opts)
--     end,
--

local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (bufferline.lua)", vim.log.levels.WARN)
  return
end

local bufferline_opts = settings.editor_plugins.bufferline

local bufferline = {}

if bufferline_opts.enable then
  bufferline = {
    "akinsho/bufferline.nvim",
    event = bufferline_opts.event,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    keys = bufferline_opts.keys,
    config = function()
      local bufferline_status, bufferline_ = pcall(require, "bufferline")
      if not bufferline_status then
        vim.notify("Plugin [bufferline] failed to load", vim.log.levels.WARN)
        return
      end

      local icons_status, icons = pcall(require, "icons")
      if not icons_status then
        vim.notify("[icons] failed to load within (bufferline.lua)", vim.log.levels.WARN)
        return
      end

      bufferline_.setup({
        options = {
          numbers = "none", -- Available: none | original | buffer_id | both

          close_command = function(n)
            require("mini.bufremove").delete(n, false)
          end,

          highlights = {
            buffer_selected = { italic = true, bold = true },
            diagnostic_selected = { italic = false },
            hint_selected = { italic = false },
            pick_selected = { italic = false },
            pick_visible = { italic = false },
            pick = { italic = false },
          },
          custom_highlights = {
            BufferLineBufferSelected = { style = { "bold" } },
          },
          always_show_bufferline = true,
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",

          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(_, _, diag)
            local ret = (diag.error and icons.diagnostics.warn .. diag.error .. " " or "")
              .. (diag.warning and icons.diagnostics.Warn .. diag.warning or "")
            return vim.trim(ret)
          end,
          offsets = {
            {
              filetype = "neo-tree",
              text = "|...........FileExplorer...........|",
              highlight = "Directory",
              text_align = "left",
            },
          },
        },
      })
    end,
  }
end

return bufferline

local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (noice.lua)", vim.log.levels.WARN)
  return
end

local noice_opts = settings.ui_plugins.noice

local noice = {}

if noice_opts.enable then
  noice = {
    "folke/noice.nvim",
    event = noice_opts.event,
    keys = noice_opts.keys,
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      lsp = {
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
      },
    },
    -- opts = {
    --   lsp = {
    --     override = {
    --       ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --       ["vim.lsp.util.stylize_markdown"] = true,
    --       ["cmp.entry.get_documentation"] = true,
    --     },
    --     hover = {
    --       enabled = false,
    --     },
    --     signature = {
    --       enabled = false,
    --     },
    --   },
    --   routes = {
    --     {
    --       filter = {
    --         event = "msg_show",
    --         any = {
    --           { find = "%d+L, %d+B" },
    --           { find = "; after #%d+" },
    --           { find = "; before #%d+" },
    --         },
    --       },
    --       view = "mini",
    --     },
    --   },
    --   presets = {
    --     bottom_search = true,
    --     command_palette = true,
    --     long_message_to_split = true,
    --     inc_rename = true,
    --     lsp_doc_border = true,
    --   },
    -- },
  }
end
return noice

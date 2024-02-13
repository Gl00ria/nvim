local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (c.lua)", vim.log.levels.WARN)
  return
end

local clangd_opts = settings.langs_control.clangd

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (c.lua)", vim.log.levels.WARN)
  return
end

local function if_clangd_executable()
  if vim.fn.executable("clangd") == 1 then
    lspconfig.clangd.setup({
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.clangd").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
      root_dir = require("Gl0riVim.plugins.00_config.lsp.servers.clangd").root_dir,
      cmd = require("Gl0riVim.plugins.00_config.lsp.servers.clangd").cmd,
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
      filetypes = { "c", "cpp", "cc" },
      flags = {
        debounce_text_changes = 500,
      },
    })
  else
    vim.notify("[clangd] is not executable, please install 'clangd'", vim.log.levels.WARN)
  end
end

-- local function if_ccls_executable()
--   if vim.fn.executable("ccls") == 1 then
--     lspconfig.ccls.setup({
--       capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
--       handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
--       settings = require("Gl0riVim.plugins.00_config.lsp.servers.cssls").settings,
--       init_options = {
--         cache = {
--           directory = ".ccls-cache",
--         },
--         highlight = {
--           lsRanges = true,
--         },
--       },
--     })

--     require("util").on_attach(function(client)
--       require("Gl0riVim.plugins.00_config.lsp.servers.cssls").on_attach(client)
--     end)
--   else
--     vim.notify("[ccls] is not executable, please install 'ccls'", vim.log.levels.WARN)
--   end
-- end

local clangd = {}
if clangd_opts.enable then
  clangd = {
    if_clangd_executable(),
  }
end

-- local ccls = {}
-- if settings.enable_langs_ccls then
--   ccls = {
--     if_ccls_executable(),
--   }
-- end

local clangd_extenstions = {}
if clangd_opts.extension then
  clangd_extenstions = {
    {
      "p00f/clangd_extensions.nvim",
      ft = clangd_opts.ft,
      keys = clangd_opts.keys,
      opts = {
        inlay_hints = {
          inline = vim.fn.has("nvim-0.10") == 1,
          -- Options other than `highlight' and `priority' only work
          -- if `inline' is disabled
          -- Only show inlay hints for the current line
          only_current_line = false,
          -- Event which triggers a refresh of the inlay hints.
          -- You can make this { "CursorMoved" } or { "CursorMoved,CursorMovedI" } but
          -- not that this may cause  higher CPU usage.
          -- This option is only respected when only_current_line and
          -- autoSetHints both are true.
          only_current_line_autocmd = { "CursorHold" },
          -- whether to show parameter hints with the inlay hints or not
          show_parameter_hints = true,
          -- prefix for parameter hints
          parameter_hints_prefix = "<- ",
          -- prefix for all the other hints (type, chaining)
          other_hints_prefix = "=> ",
          -- whether to align to the length of the longest line in the file
          max_len_align = false,
          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,
          -- whether to align to the extreme right or not
          right_align = false,
          -- padding from the right if right_align is true
          right_align_padding = 7,
          -- The color of the hints
          highlight = "Comment",
          -- The highlight group priority for extmark
          priority = 100,
        },
        ast = {
          -- These require codicons (https://github.com/microsoft/vscode-codicons)
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },

          kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
          },

          highlights = {
            detail = "Comment",
          },
        },
        memory_usage = {
          border = "none",
        },
        symbol_info = {
          border = "none",
        },
      },
    },
  }
end

local clangd_treesitter = {}
if clangd_opts.ts_clangd then
  clangd_treesitter = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "c", "cpp" })
      end
    end,
  }
end

return {
  clangd,
  -- ccls,
  clangd_treesitter,
  clangd_extenstions,
}

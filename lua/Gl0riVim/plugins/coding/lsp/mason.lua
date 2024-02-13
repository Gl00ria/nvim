local control_center_status, settings = pcall(require, "control_center")
if not control_center_status then
  vim.notify("[settings] failed to load within (lspkeymaps.lua)", vim.log.levels.WARN)
  return
end

local mason_opts = settings.coding_plugins.mason

local mason = {}

if mason_opts.enable then
  mason = {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    build = ":MasonUpdate",
    cmd = mason_opts.cmd,
    keys = mason_opts.keys,
    opts = {
      ensure_installed = {
        "stylua",
      },
      ui = {
        border = "double", -- Available: "none", "single", "double", "rounded", "solid", "shadow"
        icons = {
          package_installed = "",
          package_pending = "󰾨",
          package_uninstalled = "",
        },
      },
    },
    config = function(_, opts)
      local mason_status, mason_ = pcall(require, "mason")
      if not mason_status then
        vim.notify("Plugin [mason] failed to load within (coding.lsp.mason.lua)", vim.log.levels.WARN)
        return
      end

      local mason_registry_status, mr = pcall(require, "mason-registry")
      if not mason_registry_status then
        vim.notify("[mason registry] failed to load within (coding.lsp.mason.lua)", vim.log.levels.WARN)
        return
      end

      mason_.setup(opts)
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  }
end

return mason

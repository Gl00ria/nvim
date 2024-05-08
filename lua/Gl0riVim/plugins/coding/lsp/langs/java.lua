local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (java.lua)", vim.log.levels.WARN)
  return
end

local java_opts = settings.langs_control.java

local java = {}
local java_treesitter = {}
local jdtls = {}

if java_opts.enable then
  java = {
    keys = java_opts.keys,
    ft = { "java" },
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "nvim-java/nvim-java-refactor",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
    config = function()
      local java_status, java_ = pcall(require, "java")
      if not java_status then
        vim.notify("Plugin [java] failed to load within (java.lua)", vim.log.levels.WARN)
        return
      end
      java_.setup()

      local lsp_jdtls_status, lsp_jdtls = pcall(require, "lspconfig")
      if not lsp_jdtls_status then
        vim.notify("[lspconfig] failed to load within (java.lua)", vim.log.levels.WARN)
        return
      end
      lsp_jdtls.jdtls.setup({})
    end,
  }

  if java_opts.ts_java then
    java_treesitter = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "java" })
        end
      end,
    }
  end

  if java_opts.jdtls then
    jdtls = {
      {
        "mfussenegger/nvim-jdtls",
      },
    }
  end
end

return {
  java,
  jdtls,
  java_treesitter,
}

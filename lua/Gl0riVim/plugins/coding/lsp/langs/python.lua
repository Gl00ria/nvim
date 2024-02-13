local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (python.lua)", vim.log.levels.WARN)
  return
end

local python_opts = settings.langs_control.python

local venv_path = os.getenv("VIRTUAL_ENV")
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
  py_path = venv_path .. "/bin/python3"
else
  py_path = vim.g.python3_host_prog
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  vim.notify("[lspconfig] failed to load within (python.lua)", vim.log.levels.WARN)
  return
end

local python = {}
local python_treesitter = {}
local python_semshi = {}
local python_conform = {}
local neotest_python = {}
local dap_python = {}
local python_env_select = {}

if python_opts.enable then
  python = {
    lspconfig.pylsp.setup({
      capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
      handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
      settings = {
        pylsp = {
          plugins = {
            -- type checker
            pylsp_mypy = {
              enabled = true,
              overrides = { "--python-executable", py_path, true },
              report_progress = true,
              live_mode = false,
            },
            -- auto-completion options
            jedi_completion = { fuzzy = true },
          },
        },
      },
      flags = {
        debounce_text_changes = 200,
      },
    }),
    -- lspconfig.pyright.setup({
    -- capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
    -- handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
    -- }),
    require("util").on_attach(function(client)
      require("Gl0riVim.plugins.00_config.lsp.servers.python").attach(client)
    end),
  }
  if python_opts.ts_python then
    python_treesitter = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, {
            "ninja",
            "python",
            "rst",
            "toml",
          })
        end
      end,
    }
  end

  if python_opts.neotest_python then
    neotest_python = {
      ft = { "python" },
      "nvim-neotest/neotest-python",
    }
  end

  if python_opts.env_select then
    python_env_select = {
      "linux-cultist/venv-selector.nvim",
      dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
      keys = { python_opts.keys.select_venv },
      opts = {
        name = {
          "venv",
          ".venv",
          "env",
          ".env",
        },
      },
    }
  end

  if python_opts.conform_python then
    python_conform = {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          python = { "isort", "black" },
        },
      },
    }
  end

  if python_opts.dap_python then
    dap_python = {
      "mfussenegger/nvim-dap-python",
      keys = python_opts.keys.dap_python_keys,
      config = function()
        local path = require("mason-registry").get_package("debugpy"):get_install_path()
        require("dap-python").setup(path .. "/venv/bin/python")
      end,
    }
  end

  if python_opts.semshi_python then
    python_semshi = {
      "wookayin/semshi",
      build = ":UpdateRemotePlugins",
      version = "*", -- Recommended to use the latest release
      ft = "python",
      init = function()
        -- Disabled these features better provided by LSP or other more general plugins
        vim.g["semshi#error_sign"] = false
        vim.g["semshi#simplify_markup"] = false
        vim.g["semshi#mark_selected_nodes"] = false
        vim.g["semshi#update_delay_factor"] = 0.001

        -- This autocmd must be defined in init to take effect
        vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
          group = vim.api.nvim_create_augroup("SemanticHighlight", {}),
          callback = function()
            -- Only add style, inherit or link to the LSP's colors
            vim.cmd([[
        highlight! semshiGlobal gui=italic
        highlight! link semshiImported @none
        highlight! link semshiParameter @lsp.type.parameter
        highlight! link semshiParameterUnused DiagnosticUnnecessary
        highlight! link semshiBuiltin @function.builtin
        highlight! link semshiAttribute @field
        highlight! link semshiSelf @lsp.type.selfKeyword
        highlight! link semshiUnresolved @lsp.type.unresolvedReference
        highlight! link semshiFree @none
        ]])
          end,
        })
      end,
    }
  end
end

return {
  python,
  python_env_select,
  python_conform,
  python_semshi,
  dap_python,
  neotest_python,
  python_treesitter,
}

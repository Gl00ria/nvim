local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (coding/lsp/lspconfig.lua)", vim.log.levels.WARN)
  return
end

local lsp_conf = {}

if settings.coding_plugins.lspconfig.enable then
  lsp_conf = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    keys = settings.coding_plugins.lspconfig.keys,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "nvim-lua/plenary.nvim",
      "b0o/schemastore.nvim",
      "folke/neodev.nvim",
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    },
    opts = {
      diagnostics = {
        severity_sort = true,
      },
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      servers = {},
      setup = {},
    },
    config = function(_, opts)
      local lspui_status, lspui = pcall(require, "lspconfig.ui.windows")
      if not lspui_status then
        vim.notify("[lspui] failed to load within (coding.lspconfig.lua)", vim.log.levels.WARN)
        return
      end

      --LspInfo Borders
      lspui.default_options.border = "double"

      -- Style floating windows
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      -- Auto Formatting
      -- sometimes it shows ( [LPS] format request failed, no matching language servers )
      -- vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      local servers = opts.servers
      local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities())

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end
      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end

      local neodev_status, neodev = pcall(require, "neodev")
      if not neodev_status then
        vim.notify("Plugin [neodev] failed to load within (coding.lspconfig.lua)", vim.log.levels.WARN)
        return
      end

      local lspconfig_status, lspconfig = pcall(require, "lspconfig")
      if not lspconfig_status then
        vim.notify("Plugin [lspconfig] failed to load within (coding.lspconfig.lua)", vim.log.levels.WARN)
        return
      end

      local util_status, util = pcall(require, "util")
      if not util_status then
        vim.notify("[Util] failed to load within (coding.lspconfig.lua)", vim.log.levels.WARN)
        return
      end

      vim.diagnostic.config({
        update_in_insert = settings.update_in_insert,
      })

      util.on_attach(function(client, buffer)
        require("Gl0riVim.plugins.00_config.lsp.lspkeymaps").attach(client, buffer)
        if settings.enable_inlayhints then
          require("Gl0riVim.plugins.00_config.lsp.inlayhints").attach(client, buffer)
        end
        if settings.enable_git_signs then
          require("Gl0riVim.plugins.00_config.lsp.gitsettings").attach(client, buffer)
        end
      end)

      local showdiag = settings.show_diagnostics
      if showdiag == "none" then
        vim.diagnostic.config(require("Gl0riVim.plugins.00_config.lsp.lsp_diagnostics")["off"])
      else
        vim.diagnostic.config(require("Gl0riVim.plugins.00_config.lsp.lsp_diagnostics")["on"])
      end
      if showdiag == "popup" then
        vim.cmd([[
    autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
  ]])
      end

      -- local runtime_path = vim.split(package.path, ";")
      -- table.insert(runtime_path, "lua/?.lua")
      -- table.insert(runtime_path, "lua/?/init.lua")

      lspconfig.lua_ls.setup({
        cmd = { "lua-language-server" },
        filetypes = { "lua" },

        capabilities = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").capabilities,
        handlers = require("Gl0riVim.plugins.00_config.lsp.servers.00_handlers_capabilites").handlers,
        root_dir = lspconfig.util.root_pattern(
          ".luarc.json",
          ".luarc.jsonc",
          ".luacheckrc",
          ".stylua.toml",
          "stylua.toml",
          "selene.toml",
          "selene.yml",
          ".git"
        ),
        neodev.setup({
          library = { plugins = { "nvim-dap-ui" }, types = true },
          setup_jsonls = true,
          lspconfig = false,
          pathStrict = true,
          override = function(root_dir, library)
            local neodev_util = require("neodev.util")
            if neodev_util.has_file(root_dir, "/etc/nixos") or util.has_file(root_dir, "nvim-config") then
              library.enabled = true
              library.plugins = true
            end
          end,
        }),
        -- These settings will meaningfully increase the time until lua_ls
        -- can service initial requests (completion, location) upon starting as well
        -- as time to first diagnostics. Completion results will include a workspace
        -- indexing progress message until the server has finished indexing.
        before_init = require("neodev.lsp").before_init,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              -- path = runtime_path,
            },
            diagnostics = {
              globals = require("Gl0riVim.plugins.00_config.lsp.servers.luals").settings.Lua.diagnostics.globals,
              disable = { "missing-fields" },
            },
            hint = {
              enable = true,
            },
            -- workspace = {
            --   checkThirdParty = false,
            --   library = vim.api.nvim_get_runtime_file("", true),
            -- },
            workspace = {
              -- make language server aware of runtime files
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
    end,
  }
end

return lsp_conf

local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (rust.lua)", vim.log.levels.WARN)
  return
end

local rust_opts = settings.langs_control.rust

local rust = {}
local treesitter_rust = {}
local mason_rust = {}

if rust_opts.enable then
  rust = {
    {
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      opts = {
        src = {
          cmp = { enabled = true },
        },
      },
    },
    {
      "simrat39/rust-tools.nvim",
      lazy = true,
      opts = function()
        local ok, mason_registry = pcall(require, "mason-registry")
        local adapter ---@type any
        if ok then
          -- rust tools configuration for debugging support
          local codelldb = mason_registry.get_package("codelldb")
          local extension_path = codelldb:get_install_path() .. "/extension/"
          local codelldb_path = extension_path .. "adapter/codelldb"
          local liblldb_path = ""
          if vim.loop.os_uname().sysname:find("Windows") then
            liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
          elseif vim.fn.has("mac") == 1 then
            liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
          else
            liblldb_path = extension_path .. "lldb/lib/liblldb.so"
          end
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
        end
        return {
          dap = {
            adapter = adapter,
          },
          tools = {
            on_initialized = function()
              vim.cmd([[
                augroup RustLSP
                  autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                  autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                  autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                augroup END
              ]])
            end,
          },
        }
      end,
      config = function() end,
    },
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          rust_analyzer = {
            keys = rust_opts.keys,
            settings = {
              ["rust-analyzer"] = {
                cargo = {
                  allFeatures = true,
                  loadOutDirsFromCheck = true,
                  runBuildScripts = true,
                },
                -- Add clippy lints for Rust.
                checkOnSave = {
                  allFeatures = true,
                  command = "clippy",
                  extraArgs = { "--no-deps" },
                },
                procMacro = {
                  enable = true,
                  ignored = {
                    ["async-trait"] = { "async_trait" },
                    ["napi-derive"] = { "napi" },
                    ["async-recursion"] = { "async_recursion" },
                  },
                },
              },
            },
          },
          taplo = {
            keys = {
              {
                "K",
                function()
                  if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                    require("crates").show_popup()
                  else
                    vim.lsp.buf.hover()
                  end
                end,
                desc = "Show Crate Documentation",
              },
            },
          },
        },
        setup = {
          rust_analyzer = function()
            require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
            return true
          end,
        },
      },
    },
  }

  if rust_opts.ts_rust then
    treesitter_rust = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, {
          "ron",
          "rust",
          "toml",
        })
      end,
    }
  end

  if rust_opts.mason_rust then
    mason_rust = {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, {
          "codelldb",
        })
      end,
    }
  end
end

return {
  rust,
  treesitter_rust,
  mason_rust,
}

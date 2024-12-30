return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = LazyVim.config.icons

    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "toggleterm", "dashboard", "alpha", "starter" } },
        component_separators = { left = "", right = "" },
        section_separators = { left = "█", right = "█" },
        -- separator = { left = " ", right = " " }
        -- section_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        -- separator = { left = " ", right = "" },
        -- separator = { left = "", right = "" },
        -- separator = { left = "█", right = "█" },
        always_divide_middle = false,
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },

        lualine_c = {
          -- LazyVim.lualine.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          -- { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {
          -- stylua: ignore
          -- pressed keys
          -- {
          --   function() return require("noice").api.status.command.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          --   color = function() return LazyVim.ui.fg("Statement") end,
          -- },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,

          },
          { "selectioncount" },
          -- stylua: ignore
          -- {
          --   require("lazy.status").updates,
          --   cond = require("lazy.status").has_updates,
          --   color = function() return LazyVim.ui.fg("Special") end,
          -- },
        },
        lualine_y = {
          { "filetype" },
          {
            -- Lsp server name .
            function()
              local msg = "No Active Lsp"
              local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
              local clients = vim.lsp.get_clients()
              if next(clients) == nil then return msg end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then return client.name end
              end
              return msg
            end,
            -- icon = "  LSP:",
            icon = { "  :", color = { fg = "#FFFF00" } },
          },
          {
            require("config.utils").py_vertual_env,
            color = { fg = "#98be65" },
            cond = require("config.utils").hide_in_width,
          },
        },
        lualine_z = {
          function() return " " .. os.date("%R") end,
          { "location", padding = { left = 0, right = 0 }, separator = "" },
          { require("config.utils").progress, separator = "", padding = { left = 1, right = 1 } },
          { "encoding" },
          {
            "fileformat",
            symbols = { unix = "󰣇", dos = "", mac = "" },
            separator = "",
            padding = { left = 0, right = 1 },
          },
        },
      },
      extensions = { "neo-tree", "lazy" },
    }

    -- do not add trouble symbols if aerial is enabled
    if vim.g.trouble_lualine then
      local trouble = require("trouble")
      local symbols = trouble.statusline
        and trouble.statusline {
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        }
      table.insert(opts.sections.lualine_c, {
        symbols and symbols.get,
        cond = symbols and symbols.has,
      })
    end

    return opts
  end,
}

vim.pack.add { 'https://github.com/nvim-lualine/lualine.nvim' }

local icons = require('gl00ria.config.icons').kinds.diagnostic

local ok, lualine = pcall(require, 'lualine')
if ok then
  lualine.setup {
    options = {
      theme = 'auto',
      globalstatus = vim.o.laststatus == 3,
      disabled_filetypes = { statusline = { 'toggleterm', 'dashboard', 'alpha', 'starter' } },
      component_separators = { left = '', right = '' },
      section_separators = { left = '█', right = '█' },
      -- separator = { left = " ", right = " " }
      -- section_separators = { left = "", right = "" },
      -- section_separators = { left = "", right = "" },
      -- separator = { left = " ", right = "" },
      -- separator = { left = "", right = "" },
      -- separator = { left = "█", right = "█" },
      always_divide_middle = false,
    },

    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        {
          'diff',
          -- symbols = { added = ' ', modified = '~ ', removed = ' ' },
          -- source = function()
          --   local gitsigns = vim.b.gitsigns_status_dict
          --   if gitsigns then
          --     return {
          --       added = gitsigns.added,
          --       modified = gitsigns.changed,
          --       removed = gitsigns.removed,
          --     }
          --   end
          -- end,
        },
      },

      lualine_c = {
        {
          'diagnostics',
          symbols = {
            error = icons.err,
            warn = icons.warn,
            info = icons.info,
            hint = icons.hint,
          },
        },
      },
      lualine_x = {
          -- stylua: ignore
          -- pressed keys
          -- {
          --   function() return require("noice").api.status.command.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          -- },
          -- stylua: ignore
          -- {
          --   function() return require("noice").api.status.mode.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          -- },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,

          },
        { 'selectioncount' },
        -- stylua: ignore
        -- {
        --   require("lazy.status").updates,
        --   cond = require("lazy.status").has_updates,
        -- },
      },
      lualine_y = {
        { 'filetype' },
        {
          -- Lsp server name .
          function()
            local msg = 'No Active Lsp'
            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then return msg end
            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes
              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then return client.name end
            end
            return msg
          end,
          -- icon = "  LSP:",
          icon = { '  :', color = { fg = '#FFFF00' } },
        },
        {
          require('utils').py_vertual_env,
          color = { fg = '#98be65' },
          cond = require('utils').hide_in_width,
        },
      },
      lualine_z = {
        function() return ' ' .. os.date '%R' end,
        { 'location', padding = { left = 0, right = 0 }, separator = '' },
        { require('utils').progress, separator = '', padding = { left = 1, right = 1 } },
        { 'encoding' },
        {
          'fileformat',
          symbols = { unix = '󰣇', dos = '', mac = '' },
          separator = '',
          padding = { left = 0, right = 1 },
        },
      },
    },
    extensions = { 'neo-tree', 'lazy' },
  }
else
  vim.notify('Failed to load plugin [Lualine@lualine.lua]', vim.log.levels.ERROR)
end

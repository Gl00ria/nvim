vim.pack.add {
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' },
  { src = 'https://github.com/saghen/blink.compat' }, -- to use sources from cmp

  --
  -- sources
  --
  { src = 'https://github.com/folke/lazydev.nvim' },

  { src = 'https://github.com/alexandre-abrioux/blink-cmp-npm.nvim' },

  -- pops up too much
  -- { src = 'https://github.com/mikavilpas/blink-ripgrep.nvim' },

  { src = 'https://github.com/saghen/blink.lib' },
  { src = 'https://github.com/bydlw98/blink-cmp-env' },

  -- { src = 'https://github.com/Kaiser-Yang/blink-cmp-git' },
  -- { src = 'https://github.com/Kaiser-Yang/blink-cmp-dictionary' },
  -- { src = 'https://github.com/disrupted/blink-cmp-conventional-commits' },

  -- eye-candy
  { src = 'https://github.com/onsails/lspkind.nvim' },
  { src = 'https://github.com/xzbdmw/colorful-menu.nvim' },
}

local lazy = require 'gl00ria.config.lazy'
lazy.on_event('InsertEnter', function()
  local blink_ok, blink = pcall(require, 'blink.cmp')
  if blink_ok then
    -- Emacs behavior for 'blink.cmp'
    --https://cmp.saghen.dev/recipes.html#show-on-newline-tab-and-space
    --
    local has_words_before = function()
      local col = vim.api.nvim_win_get_cursor(0)[2]
      if col == 0 then return false end
      local line = vim.api.nvim_get_current_line()
      return line:sub(col, col):match '%s' == nil
    end

    blink.setup {
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
          'dadbod',
          'env',
          'lazydev',
          'npm',
          -- 'ripgrep',
          -- 'dictionary',
          -- 'conventional_commits',
          -- 'git',
        },
        providers = {
          snippets = { name = ' ' },
          lsp = { name = ' ', fallbacks = {} },
          path = { name = ' ' },

          -- Sql
          dadbod = { name = ' ', module = 'vim_dadbod_completion.blink' },

          -- ripgrep = {
          --   module = 'blink-ripgrep',
          --   name = 'Ripgrep',
          --   -- see the full configuration below for all available options
          --   ---@module "blink-ripgrep"
          --   ---@type blink-ripgrep.Options
          --   opts = {},
          -- },

          env = {
            name = ' ',
            module = 'blink-cmp-env',
            opts = {
              item_kind = require('blink.cmp.types').CompletionItemKind.Variable,
              show_braces = false,
              show_documentation_window = true,
            },
          },

          npm = {
            name = ' ',
            module = 'blink-cmp-npm',
            async = true,
            -- optional - make blink-cmp-npm completions top priority (see `:h blink.cmp`)
            score_offset = 100,
            -- optional - blink-cmp-npm config
            ---@module "blink-cmp-npm"
            opts = {
              ignore = {},
              only_semantic_versions = true,
              only_latest_version = false,
            },
          },

          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },

          buffer = {
            name = ' ',
            -- min_keyword_length = 3,
            score_offset = -3,
            opts = {
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr) return vim.bo[bufnr].buftype == '' end, vim.api.nvim_list_bufs())
              end,
            },
          },
          -- dictionary = {
          --   module = 'blink-cmp-dictionary',
          --   name = 'Dict',
          --   -- 💡 Performance impact of min_keyword_length:
          --   -- - In fallback mode: No impact on performance regardless of value
          --   -- - With fzf: Higher values may improve performance
          --   -- - With other commands (rg/grep): Higher values significantly improve performance
          --   min_keyword_length = 1,
          --   -- options for blink-cmp-dictionary
          --   opts = {
          --     -- put your dictionary files here
          --     dictionary_files = { vim.fn.expand '~/.config/nvim/english.dict' },
          --   },
          -- },

          -- conventional_commits = {
          --   name = 'Conventional Commits',
          --   module = 'blink-cmp-conventional-commits',
          --   enabled = function() return vim.bo.filetype == 'gitcommit' end,
          -- },
          -- git = {
          --   module = 'blink-cmp-git',
          --   name = 'Git',
          -- },
        },
      },

      keymap = {
        preset = 'enter',
        -- If completion hasn't been triggered yet, insert the first suggestion; if it has, cycle to the next suggestion.
        ['<Tab>'] = {
          function(cmp)
            if has_words_before() then return cmp.insert_next() end
          end,
          'fallback',
        },
        -- Navigate to the previous suggestion or cancel completion if currently on the first one.
        ['<S-Tab>'] = { 'insert_prev' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        ghost_text = { enabled = true },
        trigger = { show_on_keyword = true },

        menu = {
          auto_show_delay_ms = 100,
          border = 'none',
          draw = {
            treesitter = { 'lsp' },
            columns = { { 'kind_icon' }, { 'label', gap = 1 }, { 'label_description' }, { 'source_name' } },
            components = {
              -- https://github.com/onsails/lspkind.nvim/issues/90
              kind_icon = {
                text = function(ctx) return require('lspkind').symbol_map[ctx.kind] or '' end,
              },
              label = {
                text = function(ctx) return require('colorful-menu').blink_components_text(ctx) end,
                highlight = function(ctx) return require('colorful-menu').blink_components_highlight(ctx) end,
              },
            },
          },
        },
        documentation = {
          auto_show = true,
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See `:help blink-cmp-config-fuzzy` for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = {
        enabled = true,
        window = {
          -- show_documentation = true,
        },
      },

      cmdline = {
        enabled = true,
        keymap = {
          preset = 'cmdline',
          ['<Right>'] = false,
          ['<Left>'] = false,
        },
        completion = {
          list = { selection = { preselect = false } },
          menu = {
            auto_show = function(ctx) return vim.fn.getcmdtype() == ':' end,
          },
          ghost_text = { enabled = true },
        },
      },
    }
  else
    vim.notify('Failed to load plugin [blink@blink-cmp.lua]', vim.log.levels.ERROR)
  end
end, 'blink_cmp')

-- vim: ts=2 sts=2 sw=2 et

local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (cmp.lua)", vim.log.levels.WARN)
  return
end

return {
  "hrsh7th/nvim-cmp",
  event = settings.coding_plugins.cmp.event,
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    -- "uga-rosa/cmp-dictionary", -- Great one, but slows down CMP & the editor itself
    "hrsh7th/cmp-calc",
    -- { "Gelio/cmp-natdat", opts = { cmp_kind_text = "" } }, PERF: use 'Luasnip' --> dateDMY, dateMDY
  },
  config = function()
    local cmp_status, cmp = pcall(require, "cmp")
    if not cmp_status then
      vim.notify("[cmp] failed to load within (cmp.lua)", vim.log.levels.WARN)
      return
    end
    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if not snip_status_ok then
      vim.notify("[luasnip] failed to load within (cmp.lua)", vim.log.levels.WARN)
      return
    end
    require("luasnip.loaders.from_vscode").lazy_load()
    local snippet_path = vim.fn.stdpath("config") .. "/snippets"
    require("luasnip.loaders.from_snipmate").load({ path = { snippet_path } })

    -- Sorting
    -- https://github.com/pysan3/dotfiles/blob/09f4b6bf8f25ed6f72478fb81bbd2d921ee681eb/nvim/lua/plugins/70-nvim-cmp.lua#L148-L179
    local cmp_compare_status, compare = pcall(require, "cmp.config.compare")
    if not cmp_compare_status then
      vim.notify("[cmp.types] failed to load within (00_config.cmp.lua)", vim.log.levels.WARN)
      return
    end

    local cmp_types_status, types = pcall(require, "cmp.types")
    if not cmp_types_status then
      vim.notify("[cmp.types] failed to load within (cmp.lua)", vim.log.levels.WARN)
      return
    end

    local modified_priority = {
      [types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Method,
      [types.lsp.CompletionItemKind.Snippet] = 0, -- top
      [types.lsp.CompletionItemKind.Keyword] = 0, -- top
      [types.lsp.CompletionItemKind.Text] = 100, -- bottom
    }
    local function modified_kind(kind)
      return modified_priority[kind] or kind
    end

    local lspkind_status, lspkind = pcall(require, "lspkind")
    if not lspkind_status then
      vim.notify("[lspkind] failed to load within (cmp.lua)", vim.log.levels.WARN)
      return
    end

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Command Line                                             │
    -- ╰──────────────────────────────────────────────────────────╯
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
    })
    cmp.setup.filetype("java", {
      completion = {
        keyword_length = 2,
      },
    })

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Highlight Groups                                         │
    -- ╰──────────────────────────────────────────────────────────╯
    -- VScode like highlights
    -- gray
    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
    -- blue
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
    -- light blue
    vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
    vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
    vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
    -- pink
    vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
    vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
    -- front
    vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
    vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
    vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })
    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Utils                                                    │
    -- ╰──────────────────────────────────────────────────────────╯
    local cmp_kinds = {
      Text = "  ",
      Method = "  ",
      Function = "  ",
      Constructor = "  ",
      Field = "  ",
      Variable = "  ",
      Class = "  ",
      Interface = "  ",
      Module = "  ",
      Property = "  ",
      Unit = "  ",
      Value = "  ",
      Enum = "  ",
      Keyword = "  ",
      Snippet = "  ",
      Color = "  ",
      File = "  ",
      Reference = "  ",
      Folder = "  ",
      EnumMember = "  ",
      Constant = "  ",
      Struct = "  ",
      Event = "  ",
      Operator = "  ",
      TypeParameter = "  ",
    }

    local tabnine_enabled = settings.enable_tabnine
    local tabnine_source = {}
    if tabnine_enabled then
      tabnine_source = { name = "tabnine" }
    end

    local codeium_enabled = settings.enable_codeium
    local codeium_source = {}
    if codeium_enabled then
      codeium_source = { name = "codeium" }
    end

    local check_backspace = function()
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    -- Complete from all visible buffers (splits)
    local buffer_option = {
      get_bufnrs = function()
        local bufs = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          bufs[vim.api.nvim_win_get_buf(win)] = true
        end
        return vim.tbl_keys(bufs)
      end,
    }

    local function limit_lsp_types(entry, ctx)
      local kind = entry:get_kind()
      local line = ctx.cursor.line
      local col = ctx.cursor.col
      local char_before_cursor = string.sub(line, col - 1, col - 1)
      local char_after_dot = string.sub(line, col, col)

      if char_before_cursor == "." and char_after_dot:match("[a-zA-Z]") then
        if
          kind == types.lsp.CompletionItemKind.Method
          or kind == types.lsp.CompletionItemKind.Field
          or kind == types.lsp.CompletionItemKind.Property
        then
          return true
        else
          return false
        end
      elseif string.match(line, "^%s+%w+$") then
        if kind == types.lsp.CompletionItemKind.Function or kind == types.lsp.CompletionItemKind.Variable then
          return true
        else
          return false
        end
      end

      return true
    end

    -- ╭──────────────────────────────────────────────────────────╮
    -- │ Setup                                                    │
    -- ╰──────────────────────────────────────────────────────────╯
    local icons_status, icons = pcall(require, "icons")
    if not icons_status then
      vim.notify("[icons] failed to load within (cmp.lua)", vim.log.levels.WARN)
      return
    end

    local source_mapping = {
      codeium = icons.misc.codeium,
      cmp_tabnine = icons.misc.light,
      copilot = icons.misc.copilot,
      npm = icons.misc.nodejs,
      nvim_lsp = icons.misc.paragraph,
      buffer = icons.misc.buffer,
      nvim_lua = icons.misc.bomb,
      luasnip = icons.misc.snippet,
      calc = icons.misc.calculator,
      rust = icons.misc.rust,
      path = icons.misc.folderOpen2,
      treesitter = icons.misc.tree,
      zsh = icons.misc.terminal,
      dit = icons.git.Github,
      spell = icons.misc.spell,
      -- dictionary = icons.misc.dictionary,
    }
    for k, v in pairs(icons.kinds) do
      source_mapping[k] = v
    end

    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
      end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end

    -- local dict_status, cmp_dict = pcall(require, "cmp_dictionary")
    -- if not dict_status then
    --   vim.notify("[cmp_dictionary] failed to load within (cmp.lua)", vim.log.levels.WARN)
    --   return
    -- end

    -- cmp_dict.setup({
    --   exact = 2,
    --   first_case_insensitive = false,
    --   document = false,
    --   document_command = "wn %s -over",
    --   sqlite = false,
    --   max_items = -1,
    --   capacity = 5,
    --   debug = false,
    -- })

    -- cmp_dict.switcher({
    --   spelllang = {
    --     en = "~/.config/nvim/english.dict",
    --   },
    -- })

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        -- ["<CR>"] = cmp.mapping.confirm({
        --     behavior = cmp.ConfirmBehavior.Replace,
        --     select = false,
        -- }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<C-l>"] = cmp.mapping(function(fallback)
          if luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<C-h>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 8, entry_filter = limit_lsp_types },
        codeium_source,
        tabnine_source,
        { name = "luasnip", priority = 9, max_item_count = 5 },
        {
          name = "buffer",
          priority = 5,
          keyword_length = 5,
          option = buffer_option,
          max_item_count = 5,
        },
        { name = "path", priority = 3 },
        -- {
        --   name = "dictionary",
        --   keyword_length = 2,
        --   priority = 10,
        -- },
        { name = "calc", priority = 2 },
        { name = "natdat", priority = 2 },
      }),
      formatting = {
        format = function(entry, vim_item)
          vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
          -- Get the item with kind from the lspkind plugin
          local item_with_kind = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            symbol_map = source_mapping,
          })(entry, vim_item)

          item_with_kind.kind = lspkind.symbolic(item_with_kind.kind, { with_text = true })
          item_with_kind.menu = source_mapping[entry.source.name]
          item_with_kind.kind = lspkind.symbolic(item_with_kind.kind, { with_text = true })
          item_with_kind.abbr = string.sub(item_with_kind.abbr, 1, item_with_kind.maxwidth)

          if entry.source.name == "tabnine" then
            if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
              item_with_kind.kind = " " .. lspkind.symbolic("Event", { with_text = false }) .. " TabNine"
              item_with_kind.menu = item_with_kind.menu .. entry.completion_item.data.detail
            else
              item_with_kind.kind = " " .. lspkind.symbolic("Event", { with_text = false }) .. " TabNine"
              item_with_kind.menu = item_with_kind.menu .. " TBN"
            end
          end

          if string.find(vim_item.kind, "Color") then
            -- Override for plugin purposes
            vim_item.kind = "Color"
            local tailwind_item = require("cmp-tailwind-colors").format(entry, vim_item)
            item_with_kind.menu = lspkind.symbolic("Color", { with_text = false }) .. " Color"
            item_with_kind.kind = " " .. tailwind_item.kind
          end

          return vim_item
        end,
        maxwidth = 50,
        ellipsis_char = "...",
      },
      matching = {
        disallow_fuzzy_matching = false, -- fmodify -> fnamemodify
        disallow_fullfuzzy_matching = true,
        disallow_partial_fuzzy_matching = true,
        disallow_partial_matching = false, -- fb -> foo_bar
        disallow_prefix_unmatching = true, -- bar -> foo_bar
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.exact,
          cmp.config.compare.locality,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.offset,
          cmp.config.compare.sort_text,
          cmp.config.compare.order,
        },
      },
      -- sorting = {
      --   comparators = {
      --     compare.offset,
      --     compare.exact,
      --     function(entry1, entry2) -- sort by length ignoring "=~"
      --       local len1 = string.len(string.gsub(entry1.completion_item.label, "[=~()_]", ""))
      --       local len2 = string.len(string.gsub(entry2.completion_item.label, "[=~()_]", ""))
      --       if len1 ~= len2 then
      --         return len1 - len2 < 0
      --       end
      --     end,
      --     compare.recently_used, ---@diagnostic disable-line
      --     function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
      --       local kind1 = modified_kind(entry1:get_kind())
      --       local kind2 = modified_kind(entry2:get_kind())
      --       if kind1 ~= kind2 then
      --         return kind1 - kind2 < 0
      --       end
      --     end,
      --     function(entry1, entry2) -- score by lsp, if available
      --       local t1 = entry1.completion_item.sortText
      --       local t2 = entry2.completion_item.sortText
      --       if t1 ~= nil and t2 ~= nil and t1 ~= t2 then
      --         return t1 < t2
      --       end
      --     end,
      --     compare.score,
      --     compare.order,
      --   },
      --   priority_weight = 2,
      -- },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      experimental = {
        ghost_text = true,
      },
      performance = {
        debounce = 60,
        throttle = 30,
        fetching_timeout = 500,
        confirm_resolve_timeout = 80,
        async_budget = 1,
        max_view_entries = 200,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
  end,
}

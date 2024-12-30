return {
  "Wansmer/symbol-usage.nvim",
  event = "LspAttach",
  config = function()
    SymbolKind = {
      File = 1,
      Module = 2,
      Namespace = 3,
      Package = 4,
      Class = 5,
      Method = 6,
      Property = 7,
      Field = 8,
      Constructor = 9,
      Enum = 10,
      Interface = 11,
      Function = 12,
      Variable = 13,
      Constant = 14,
      String = 15,
      Number = 16,
      Boolean = 17,
      Array = 18,
      Object = 19,
      Key = 20,
      Null = 21,
      EnumMember = 22,
      Struct = 23,
      Event = 24,
      Operator = 25,
      TypeParameter = 26,
    }

    --[[
 -   ╒═════════════════════════════════════════════════════════╕
 -   │                                                         │
 -   │                       Text Fromat                       │
 -   │                                                         │
 -   ╘═════════════════════════════════════════════════════════╛
]]
    local function text_format(symbol)
      local fragments = {}
      local stacked_functions = symbol.stacked_count > 0 and (" | +%s"):format(symbol.stacked_count) or ""
      if symbol.references then
        local usage = symbol.references <= 1 and "usage" or "usages"
        local num = symbol.references == 0 and "no" or symbol.references
        table.insert(fragments, ("%s %s"):format(num, usage))
      end
      if symbol.definition then table.insert(fragments, symbol.definition .. " defs") end
      if symbol.implementation then table.insert(fragments, symbol.implementation .. " impls") end
      return table.concat(fragments, ", ") .. stacked_functions
    end

    require("symbol-usage").setup {
      text_format = text_format,
      hl = { link = "Comment" },
      kinds = { SymbolKind.Function, SymbolKind.Method },
      kinds_filter = {}, -- Available: symbol:table, parent:table, bufnr:integer
      vt_position = "above", -- Available: 'above'|'end_of_line'|'textwidth'|'signcolumn'
      request_pending_text = "loading...",
      references = { enabled = true, include_declaration = false },
      definition = { enabled = false },
      implementation = { enabled = false },
      disable = { lsp = {}, filetypes = {}, cond = {} },
      -- filetypes = {},
      symbol_request_pos = "end", -- Available: start, end
    }
  end,
}

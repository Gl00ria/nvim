local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (symbol_usage.lua)", vim.log.levels.WARN)
  return
end

local symbol_opts = settings.coding_plugins.symbol_usage

local symbol_usage = {}

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
  if symbol.definition then
    table.insert(fragments, symbol.definition .. " defs")
  end
  if symbol.implementation then
    table.insert(fragments, symbol.implementation .. " impls")
  end
  return table.concat(fragments, ", ") .. stacked_functions
end
--[[
 -   ╒═════════════════════════════════════════════════════════╕
 -   │                                                         │
 -   │                      Labels Fromat                      │
 -   │                                                         │
 -   ╘═════════════════════════════════════════════════════════╛
]]
local function h(name)
  return vim.api.nvim_get_hl(0, { name = name })
end

vim.api.nvim_set_hl(0, "SymbolUsageRef", { bg = h("Type").fg, fg = h("Normal").bg, bold = true })
vim.api.nvim_set_hl(0, "SymbolUsageRefRound", { fg = h("Type").fg })

vim.api.nvim_set_hl(0, "SymbolUsageDef", { bg = h("Function").fg, fg = h("Normal").bg, bold = true })
vim.api.nvim_set_hl(0, "SymbolUsageDefRound", { fg = h("Function").fg })

vim.api.nvim_set_hl(0, "SymbolUsageImpl", { bg = h("@parameter").fg, fg = h("Normal").bg, bold = true })
vim.api.nvim_set_hl(0, "SymbolUsageImplRound", { fg = h("@parameter").fg })

local function lable_format(symbol)
  local res = {}

  -- Indicator that shows if there are any other symbols in the same line
  local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""

  if symbol.references then
    table.insert(res, { "󰍞", "SymbolUsageRefRound" })
    table.insert(res, { "󰌹 " .. tostring(symbol.references), "SymbolUsageRef" })
    table.insert(res, { "󰍟", "SymbolUsageRefRound" })
  end

  if symbol.definition then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, { "󰍞", "SymbolUsageDefRound" })
    table.insert(res, { "󰳽 " .. tostring(symbol.definition), "SymbolUsageDef" })
    table.insert(res, { "󰍟", "SymbolUsageDefRound" })
  end

  if symbol.implementation then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, { "󰍞", "SymbolUsageImplRound" })
    table.insert(res, { "󰡱 " .. tostring(symbol.implementation), "SymbolUsageImpl" })
    table.insert(res, { "󰍟", "SymbolUsageImplRound" })
  end

  if stacked_functions_content ~= "" then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, { "󰍞", "SymbolUsageImplRound" })
    table.insert(res, { " " .. tostring(stacked_functions_content), "SymbolUsageImpl" })
    table.insert(res, { "󰍟", "SymbolUsageImplRound" })
  end

  return res
end

--[[
 -   ╒═════════════════════════════════════════════════════════╕
 -   │                                                         │
 -   │                      Bubble Fromat                      │
 -   │                                                         │
 -   ╘═════════════════════════════════════════════════════════╛
]]
local function h(name)
  return vim.api.nvim_get_hl(0, { name = name })
end

-- hl-groups can have any name
vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true })

local function bubbles_fromat(symbol)
  local res = {}

  local round_start = { "", "SymbolUsageRounding" }
  local round_end = { "", "SymbolUsageRounding" }

  -- Indicator that shows if there are any other symbols in the same line
  local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""

  if symbol.references then
    local usage = symbol.references <= 1 and "usage" or "usages"
    local num = symbol.references == 0 and "no" or symbol.references
    table.insert(res, round_start)
    table.insert(res, { "󰌹 ", "SymbolUsageRef" })
    table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  if symbol.definition then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, round_start)
    table.insert(res, { "󰳽 ", "SymbolUsageDef" })
    table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  if symbol.implementation then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, round_start)
    table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
    table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  if stacked_functions_content ~= "" then
    if #res > 0 then
      table.insert(res, { " ", "NonText" })
    end
    table.insert(res, round_start)
    table.insert(res, { " ", "SymbolUsageImpl" })
    table.insert(res, { stacked_functions_content, "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  return res
end

if symbol_opts.enable then
  symbol_usage = {
    "Wansmer/symbol-usage.nvim",
    event = symbol_opts.event,
    config = function()
      require("symbol-usage").setup({
        text_format = lable_format,
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
      })
    end,
  }
end

return symbol_usage

local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyman_" .. name, { clear = true })
end

-- check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- auto insert mode for Terminal
autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
  callback = function(args)
    if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
      vim.opt_local.wrap = true
      vim.opt_local.spell = false
      vim.cmd("startinsert")
    end
  end,
})

-- no number, signcolumn, foldcolumn for Terminal
autocmd({ "TermOpen" }, {
  pattern = { "*" },
  callback = function()
    vim.opt_local["number"] = false
    vim.opt_local["signcolumn"] = "no"
    vim.opt_local["foldcolumn"] = "0"
  end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "lightgreen" })
  end,
})

-- close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query", -- :InspectTree
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
  end,
})
-- disable diagnostics in node_modules (0 is current buffer only)
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
-- enable spell checking for certain file types
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.tex" },
  command = "setlocal spell",
})
-- show `` in specific files
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.json" },
  command = "setlocal conceallevel=0",
})

local M = {}

local fn = vim.fn
local api = vim.api
local keymap = vim.keymap
local diagnostic = vim.diagnostic

-- set quickfix list from diagnostics in a certain buffer, not the whole workspace
local set_qflist = function(buf_num, severity)
  local diagnostics = nil
  diagnostics = diagnostic.get(buf_num, { severity = severity })

  local qf_items = diagnostic.toqflist(diagnostics)
  fn.setqflist({}, " ", { title = "Diagnostics", items = qf_items })

  -- open quickfix by default
  vim.cmd([[copen]])
end

local diagnostics_active = true
local toggle_diagnostics = function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    diagnostic.show()
  else
    diagnostic.hide()
  end
end

-- https://github.com/LazyVim/LazyVim/blob/a72a84972d85e5bbc6b9d60a0983b37efef21b8a/lua/lazyvim/plugins/lsp/keymaps.lua
M.diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

local control_center_status, control_center = pcall(require, "control_center")
if not control_center_status then
  vim.notify("[settings] failed to load within (lspkeymaps.lua)", vim.log.levels.WARN)
  return
end
local key = control_center.lsp_keys

M.attach = function(client, buffer)
  local map = function(mode, l, r, opts)
    opts = opts or {}
    opts.silent = true
    opts.buffer = buffer
    keymap.set(mode, l, r, opts)
  end

  map("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
  map("n", key.lsp_def, function()
    require("telescope.builtin").lsp_definitions({ reuse_win = true })
  end, { desc = "GoTo Definition" })

  map("n", key.lsp_dec, vim.lsp.buf.declaration, { desc = "GoTo Declaration" })

  map("n", key.lsp_imp, function()
    require("telescope.builtin").lsp_implementations({ reuse_win = true })
  end, { desc = "GoTo Implementation" })

  map("n", key.lsp_imp, function()
    require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
  end, { desc = "Type Definition" })

  map("n", key.lsp_signatrue_h, vim.lsp.buf.signature_help, { desc = "Signature Help" })

  map("n", key.lsp_buf_def, vim.lsp.buf.definition, { desc = "Buf Definition" })

  map("n", key.lsp_hover, vim.lsp.buf.hover, { desc = "Hover" })

  map(
    "n",
    key.lsp_float_diag,
    vim.diagnostic.open_float,
    { noremap = true, silent = true, desc = "Open floating diagnostic" }
  )
  map("n", key.lsp_toggle_diag, toggle_diagnostics, { desc = "Toggle diagnostics" })

  map("n", key.lsp_rename, vim.lsp.buf.rename, { desc = "Rename Var" })

  -- map("n", key.lsp_show_ref, vim.lsp.buf.references, { desc = "show references" })
  map("n", key.lsp_show_ref, "<cmd>Telescope lsp_references<cr>", { desc = "show references" })

  map("n", key.lsp_next_diag, M.diagnostic_goto(true), { desc = "Next Diagnostic" })
  map("n", key.lsp_prev_diag, M.diagnostic_goto(false), { desc = "Prev Diagnostic" })
  map("n", key.lsp_next_err, M.diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
  map("n", key.lsp_prev_err, M.diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
  map("n", key.lsp_next_warn, M.diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
  map("n", key.lsp_prev_warn, M.diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
  map("n", key.lsp_next_hint, M.diagnostic_goto(true, "HINT"), { desc = "Next Hint" })
  map("n", key.lsp_prev_hint, M.diagnostic_goto(false, "HINT"), { desc = "Prev Hint" })

  -- code actions
  map("n", key.lsp_code_act, vim.lsp.buf.code_action, { desc = "LSP code action" })
  map("n", key.lsp_src_code_act, function()
    vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} }, { desc = "Source Code Action" } })
  end)

  -- this puts diagnostics from opened files to quickfix
  map("n", key.lsp_win_diag_qf, diagnostic.setqflist, { desc = "Send window diagnostics to qf" })
  -- this puts diagnostics from current buffer to quickfix
  map("n", key.lsp_buf_diag_qf, function()
    set_qflist(buffer)
  end, { desc = "Send buffer diagnostics to qf" })

  map(
    "n",
    key.lsp_diag_loc_list,
    vim.diagnostic.setloclist,
    { noremap = true, silent = true, desc = "Diagnostics location list" }
  )
  -- Workspaces
  map("n", key.lsp_add_wp, vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
  map("n", key.lsp_rm_wp, vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
  map("n", key.lsp_ls_wp, function()
    vim.print(vim.lsp.buf.list_workspace_folders())
  end, { desc = "List workspace folder" })

  -- Set some key bindings conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    map("n", key.lsp_format, vim.lsp.buf.format, { desc = "format code" })
  end

  api.nvim_create_autocmd("CursorHold", {
    buffer = buffer,
    callback = function()
      local float_opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always", -- show source in diagnostic popup window
        prefix = " ",
      }

      if not vim.b.diagnostics_pos then
        vim.b.diagnostics_pos = { nil, nil }
      end

      local cursor_pos = api.nvim_win_get_cursor(0)
      if
        (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
        and #diagnostic.get() > 0
      then
        diagnostic.open_float(nil, float_opts)
      end

      vim.b.diagnostics_pos = cursor_pos
    end,
  })

  -- Highlight the current variable and its usages in the buffer.
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd([[
      hi! link LspReferenceRead Visual
      hi! link LspReferenceText Visual
      hi! link LspReferenceWrite Visual
    ]])

    local gid = api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    api.nvim_create_autocmd("CursorHold", {
      group = gid,
      buffer = buffer,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })

    api.nvim_create_autocmd("CursorMoved", {
      group = gid,
      buffer = buffer,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end

  if vim.g.logging_level == "debug" then
    local msg = string.format("Language server %s started!", client.name)
    vim.notify(msg, vim.log.levels.DEBUG, { title = "Nvim-config" })
  end
end

return M

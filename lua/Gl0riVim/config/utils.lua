local M = {}
local fn = vim.fn

-- ~/.config/nvim/lua/Gl0riVim/plugins/coding/lsp/langs/ruby.lua
-- check if a file or directory exists in this path
M.file_or_dir_exists = function(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

-- ~/.config/nvim/lua/Gl0riVim/config/keymaps.lua
M.notify = function(message, level, title)
  local notify_options = {
    title = title,
    timeout = 3000,
  }
  vim.api.nvim_notify(message, level, notify_options)
end
M.toggle_colorcolumn = function()
  local value = vim.api.nvim_get_option_value("colorcolumn", {})
  if value == "" then
    M.notify("Enable colocolumn", 1, "functions.lua")
    vim.api.nvim_set_option_value("colorcolumn", { "80", "100" }, {})
  else
    M.notify("Disable colocolumn", 1, "functions.lua")
    vim.api.nvim_set_option_value("colorcolumn", "", {})
  end
end

M.toggle_quicklist = function()
  if fn.empty(fn.filter(fn.getwininfo(), "v:val.quickfix")) == 1 then
    vim.cmd("copen")
  else
    vim.cmd("cclose")
  end
end

-- -- Automatically Compile packer whenever the plugins are updated
-- vim.cmd([[
--   augroup auto_packer_compile
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])

-- get length of current word
-- function M.get_word_length()
--     local word = vim.fn.expand("<cword>")
--     return #word
-- end

-- local diagnostics_active = true
-- function M.toggle_diagnostics()
--     diagnostics_active = not diagnostics_active
--     if diagnostics_active then
--         vim.diagnostic.show()
--     else
--         vim.diagnostic.hide()
--     end
-- end

-- check if navic's filetype-icon is empty of not
-- function M.isempty(s)
--     return s == nil or s == ""
-- end

-- function M.get_buf_option(opt)
--     local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
--     if not status_ok then
--         return nil
--     else
--         return buf_option
--     end
-- end

-- function M.on_attach(on_attach)
--     vim.api.nvim_create_autocmd("LspAttach", {
--         callback = function(args)
--             local buffer = args.buf
--             local client = vim.lsp.get_client_by_id(args.data.client_id)
--             on_attach(client, buffer)
--         end,
--     })
-- end

-- function M.enable_format_on_save()
--   vim.cmd([[
-- 	   augroup format_on_save
-- 	     autocmd!
-- 	     autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
-- 	   augroup end
-- 	 ]])
--   vim.notify("LspFormat Enabled on save")
-- end

-- function M.disable_format_on_save()
--   M.remove_augroup("format_on_save")
--   vim.notify("LspFormat Disabled on save")
-- end

-- function M.toggle_format_on_save()
--   if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
--     M.enable_format_on_save()
--   else
--     M.disable_format_on_save()
--   end
-- end

function M.remove_augroup(name)
  if vim.fn.exists("#" .. name) == 1 then
    vim.cmd("au! " .. name)
  end
end

vim.cmd([[ command! LspFormatToggle execute 'lua require("configs.functions").toggle_format_on_save()' ]])

--------------------lualine functions--------------------
--                                                     --
--                                                     --
--                                                     --
--                                                     --
--------------------lualine functions--------------------

function M.buffer_not_empty()
  return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
end

function M.hide_in_width()
  return vim.fn.winwidth(0) > 80
end

-- python environment
-- Credits:
-- (https://www.reddit.com/r/neovim/comments/16ya0fr/show_the_current_python_virtual_env_on_statusline/)
-- (https://github.com/jdhao/nvim-config/commit/3137850db67b1b45111656e8749b60eb936dfa7d)
function M.py_vertual_env()
  -- only show virtual env for Python
  if vim.bo.filetype ~= "python" then
    return ""
  end

  local conda_env = os.getenv("CONDA_DEFAULT_ENV")
  local venv_path = os.getenv("VIRTUAL_ENV")

  if venv_path == nil then
    if conda_env == nil then
      return ""
    else
      return string.format(" %s (conda)", conda_env)
    end
  else
    local venv_name = vim.fn.fnamemodify(venv_path, ":t")
    return string.format(" %s (venv)", venv_name)
  end
end

-- function M.check_git_workspace()
--     local filepath = vim.fn.expand("%:p:h")
--     local gitdir = vim.fn.finddir(".git", filepath .. ";")
--     return gitdir and #gitdir > 0 and #gitdir < #filepath
-- end

-- time
function M.time()
  return " " .. os.date("%R")
end

-- shows current activelsp
-- function M.active_lsp()
--     local msg = "No Active Lsp"
--     local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
--     local clients = vim.lsp.get_active_clients()
--     if next(clients) == nil then
--         return msg
--     end
--     for _, client in ipairs(clients) do
--         local filetypes = client.config.filetypes
--         if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--             return client.name
--         end
--     end
--     return msg
-- end

-- function M.mode_fmt(str)
--     return "-- " .. str .. " --"
-- end

-- progress bar
function M.progress()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

-- show diagnostics in a pop-up window on hover
-- Credits: (https://www.reddit.com/r/neovim/comments/uqb50c/with_native_lsp_nvimcmp_how_do_you_prevent_the/)
_G.LspDiagnosticsPopupHandler = function()
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

  -- Show the popup diagnostics window,
  -- but only once for the current cursor location (unless moved afterwards).
  if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
    vim.w.lsp_diagnostics_last_cursor = current_cursor
    vim.diagnostic.open_float(0, { scope = "cursor" })
  end
end
vim.cmd([[
augroup LSPDiagnosticsOnHover
  autocmd!
  autocmd CursorHold *   lua _G.LspDiagnosticsPopupHandler()
augroup END
]])

function M.get_os_type()
  local homedir = os.getenv("HOME")
  local user = os.getenv("USER")
  local start_i = 0
  local end_i = 0

  if homedir == nil or user == nil then
    return "unknown"
  end

  start_i, end_i = string.find(homedir, "/home/" .. user)

  if start_i ~= nil and end_i ~= nil then
    return "linux"
  else
    start_i, end_i = string.find(homedir, "/Users/" .. user)
    if start_i ~= nil and end_i ~= nil then
      return "osx"
    else
      return "other"
    end
  end
end

-- ~/.config/nvim/lua/Gl0riVim/plugins/coding/lsp/langs/shells.lua
M.table_contains = function(tbl, x)
  local found = false
  for _, v in pairs(tbl) do
    if v == x then
      found = true
    end
  end
  return found
end

return M

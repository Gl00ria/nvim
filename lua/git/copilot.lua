-- NOTE: experimental
-- vim.g.copilot_filetypes = {
--   -- ["*"] = false, disables all filetypes
--   -- 'python': "v:true -- enable specific filetype
-- }
--
vim.cmd [[
  imap <silent><script><expr> <C-A> copilot#Accept("\<cr>")
  let g:copilot_no_tab_map = v:true
]]

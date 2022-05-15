-- use a protected call so we don't error out on first use
local status_ok, pretty_fold = pcall(require, "pretty-fold")
if not status_ok then
	return
end

-- Use a protected call so we don't error out on first use
local config_status_ok, pretty_fold_preview = pcall(require, "pretty-fold.preview")
if not config_status_ok then
  return
end

-- NOTE: ft_setup() moved to nightly brunch.
-- -- c++ Doxygen comments
-- pretty_fold.ft_setup('cpp', {
--    process_comment_signs = false,
--    comment_signs = {
--       '/**', -- C++ Doxygen comments
--    },
--    stop_words = {
--       -- ╟─ "*" ──╭──────────────╮── "@brief" ──╭──────────────╮──╢
--       --          ╰─ whitespace ─╯              ╰─ whitespace ─╯
--       '%*%s*@brief%s*',
--    },
-- })
pretty_fold.setup{
   keep_indentation = false,
   fill_char = '━',
   sections = {
      left = {
         '━ ', function() return string.rep('*', vim.v.foldlevel) end, ' ━┫', 'content', '┣'
      },
      right = {
         '┫ ', 'number_of_folded_lines', ': ', 'percentage', ' ┣━━',
      }
   }
}

pretty_fold_preview.setup {
   key = 'h', -- choose 'h' or 'l' key
}

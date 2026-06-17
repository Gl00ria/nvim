--
-- keymap 'g<'
-- no enter spam anymore
-- NOTE:
-- - experminatal
-- - doesn't play will with 'noice.nvim'
require('vim._core.ui2').enable {
  enable = true,
  msg = {
    target = 'cmd',
    pager = { height = 0.5 },
    dialog = { height = 0.5 },
    cmd = { height = 0.5 },
    msg = { height = 0.5, timeout = 4500 },
  },
}

require 'gl00ria.config.options'
require 'gl00ria.config.keymaps'

-- set up vim.pack
require 'pack'

require 'gl00ria.config.autocmd'

require 'plugins'

-- The last line is called `modeline`. See `:help modeline`
--
-- basically:
-- a modeline is a way for a file to tell Vim/Neovim which editor settings should be used when that file is opened (:set ts=4 sw=4 et)
--
-- ts=2 → tabstop = 2
-- sw=2 → shiftwidth = 2
-- et → expandtab (insert spaces instead of tabs)
--
-- vim: ts=2 sts=2 sw=2 et

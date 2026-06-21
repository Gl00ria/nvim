vim.pack.add { 'https://github.com/rachartier/tiny-inline-diagnostic.nvim' }
local lazy = require 'gl00ria.config.lazy'
lazy.on_event('BufReadPost', function()
  local ok, tiny = pcall(require, 'tiny-inline-diagnostic')
  if ok then
    tiny.setup {
      options = {
        -- Available: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
        preset = 'modern',

        -- Make cursorline background transparent for diagnostics
        transparent_cursorline = true,
        use_icons_from_diagnostic = false,
        show_source = {
          enabled = true,
        },
        multilines = {
          enabled = true,
        },
        add_messages = {
          display_count = true,
        },
      },
    }
  else
    vim.notify('Failed to load plugin [tiny-inline-diagnostic@inline-diagnostics.lua]', vim.log.levels.ERROR)
  end
end, 'inline_diagnostic')

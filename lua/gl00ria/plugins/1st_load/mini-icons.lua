vim.pack.add { 'https://github.com/nvim-mini/mini.icons' }
-- If a nerd font is available, load the icons module for pretty icons in various plugins.
local ok, mini_icons = pcall(require, 'mini.icons')
if ok then
  if vim.g.have_nerd_font then
    mini_icons.setup {
      file = {
        ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' },
        ['.eslintrc.js'] = { glyph = '󰱺 ', hl = 'MiniIconsYellow' },
        ['.node-version'] = { glyph = ' ', hl = 'MiniIconsGreen' },
        ['.prettierrc'] = { glyph = ' ', hl = 'MiniIconsPurple' },
        ['.yarnrc.yml'] = { glyph = ' ', hl = 'MiniIconsBlue' },
        ['eslint.config.js'] = { glyph = '󰱺 ', hl = 'MiniIconsYellow' },
        ['package.json'] = { glyph = ' ', hl = 'MiniIconsGreen' },
        ['tsconfig.json'] = { glyph = ' ', hl = 'MiniIconsAzure' },
        ['tsconfig.build.json'] = { glyph = ' ', hl = 'MiniIconsAzure' },
        ['yarn.lock'] = { glyph = ' ', hl = 'MiniIconsBlue' },
      },
      filetype = {
        gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
      },
    }

    -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
    MiniIcons.mock_nvim_web_devicons()
  end
else
  vim.notify('Failed to load plugin [Mini-icons@mini-icons.lua]', vim.log.levels.ERROR)
end

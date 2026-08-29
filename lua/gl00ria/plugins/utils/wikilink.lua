vim.pack.add { 'https://github.com/YedTheEmo/graf.nvim' }

local lazy = require 'gl00ria.config.lazy'
lazy.on_event('FileType', function()
  local ok, graf = pcall(require, 'graf')
  if ok then
    graf.setup {
      root = nil, -- default: git root, else cwd
      extensions = { 'md', 'mdx' },
      ignore = { '.git', '.obsidian', 'node_modules' },
      case_sensitive = false,
      completion = { auto_trigger = true, fuzzy = true, max_items = 100 },
      highlights = {
        resolved = 'GrafLinkResolved',
        unresolved = 'GrafLinkUnresolved',
        ambiguous = 'GrafLinkAmbiguous',
        diagnostics = false,
        debounce_ms = 300,
      },
      maps = { follow = '<CR>', new = nil },
      graf = { bin = nil, preview_width = 45, auto_refresh = true, default_flags = { '--theme', 'Gruvbox', '--labels' } },
    }
  else
    vim.notify('Failed to load plugin [graf@wikilink.lua]', vim.log.levels.ERROR)
  end
end, 'wikilink', { pattern = 'markdown', 'mdx' })

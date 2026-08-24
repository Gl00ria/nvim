vim.pack.add {
  'https://github.com/selimacerbas/markdown-preview.nvim',
  'https://github.com/selimacerbas/live-server.nvim',
}

local lazy = require 'gl00ria.config.lazy'
lazy.on_event('FileType', function()
  local ok, md_preview = pcall(require, 'markdown_preview')
  if ok then
    md_preview.setup {
      -- all optional; sane defaults shown
      instance_mode = 'multi', -- "takeover" (one tab) or "multi" (tab per instance)
      port = 0, -- 0 = auto (8421 for takeover, OS-assigned for multi)
      open_browser = true,
      default_theme = 'dark', -- "dark" or "light"; initial preview theme
      debounce_ms = 300,
    }
  else
    vim.notify('Failed to load plugin [markdown-preview@markdown-preview.lua]', vim.log.levels.ERROR)
  end
end, 'render_md', { pattern = 'markdown', 'Avante' })

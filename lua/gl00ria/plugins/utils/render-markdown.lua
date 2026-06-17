vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

local ok, render_md = pcall(require, 'render-markdown')
if ok then
  render_md.setup {}
else
  vim.notify('Failed to load plugin [render-markdown@render-markdown.lua]', vim.log.levels.ERROR)
end

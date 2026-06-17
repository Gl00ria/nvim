--
-- server installed @coding/lsp/mason.lua
--
-- https://github.com/vuejs/language-tools/wiki/Neovim
local vue_language_server_path = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'
local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
local filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}
local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = tsserver_filetypes,
}

local ts_ls_config = {
  init_options = {
    plugins = {
      vue_plugin,
    },
  },
  filetypes = tsserver_filetypes,
}

local vue_ls_config = {}

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    --
    -- tsgo's newer & faster, but
    -- `ts_ls`, `vtsls`, or `typescript-tools` lsp client required by `vue_ls`
    --
    vim.lsp.config('vtsls', vtsls_config)
    vim.lsp.config('vue_ls', vue_ls_config)
    vim.lsp.config('ts_ls', ts_ls_config)
    vim.lsp.enable { 'tsgo', 'vtsls', 'vue_ls' } -- If using `ts_ls` replace `vtsls` to `ts_ls`
  end,
})

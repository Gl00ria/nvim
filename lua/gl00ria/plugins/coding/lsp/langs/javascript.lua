local filetypes = {
  'css',
  'html',
  'javascript',
  'javascriptreact',
  -- 'less',
  -- 'typescriptreact',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    local servers = {
      emmet_language_server = {
        filetypes = filetypes,
        init_options = {
          includeLanguages = {},
          excludeLanguages = {},
          extensionsPath = {},
          preferences = {},
          showAbbreviationSuggestions = true,
          showExpandedAbbreviation = 'always',
          showSuggestionsAsSnippets = false,
          syntaxProfiles = {},
          variables = {},
        },
      },
      emmet_ls = {
        filetypes = filetypes,
      },
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})

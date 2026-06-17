--
-- server installed @coding/lsp/mason.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#clangd
--

-- still no 'blink' implementation
-- https://github.com/dchinmay2/clangd_extensions.nvim/issues/74
--
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  callback = function()
    vim.pack.add { 'https://github.com/dchinmay2/clangd_extensions.nvim' }
    require('clangd_extensions').setup {
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = '',
          declaration = '',
          expression = '',
          specifier = '',
          statement = '',
          ['template argument'] = '',
        },
        kind_icons = {
          Compound = '',
          Recovery = '',
          TranslationUnit = '',
          PackExpansion = '',
          TemplateTypeParm = '',
          TemplateTemplateParm = '',
          TemplateParamObject = '',
        },
      },
    }
    local servers = {
      clangd = {
        capabilities = {
          offsetEncoding = { 'utf-16', 'utf-8' },
        },
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--header-insertion=iwyu',
          '--completion-style=detailed',
          '--function-arg-placeholders',
          '--fallback-style=llvm',
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
        root_markers = {
          'compile_commands.json',
          'compile_flags.txt',
          'configure.ac',
          'Makefile',
          'configure.ac',
          'configure.in',
          'config.h.in',
          'meson.build',
          'meson_options.txt',
          'build.ninja',
          '.clangd',
          '.clang-tidy',
          '.clang-format',
          'configure.ac',
          '.git',
        },
      },
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})

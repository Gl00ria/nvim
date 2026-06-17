--
-- server installed @coding/lsp/mason.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#tailwindcss
--

local filetypes = {
  'aspnetcorerazor',
  'astro',
  'astro-markdown',
  'blade',
  'clojure',
  'django-html',
  'htmldjango',
  'edge',
  'eelixir',
  'elixir',
  'ejs',
  'erb',
  'eruby',
  'gohtml',
  'gohtmltmpl',
  'haml',
  'handlebars',
  'hbs',
  'html',
  'htmlangular',
  'html-eex',
  'heex',
  'jade',
  'leaf',
  'liquid',
  -- 'markdown',
  'mdx',
  'mustache',
  'njk',
  'nunjucks',
  'php',
  'razor',
  'slim',
  'twig',
  'css',
  'less',
  'postcss',
  'sass',
  'scss',
  'stylus',
  'sugarss',
  'javascript',
  'javascriptreact',
  'reason',
  'rescript',
  'typescript',
  'typescriptreact',
  'vue',
  'svelte',
  'templ',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    local servers = {
      tailwindcss = {
        filetypes = filetypes,
        init_options = {
          userLanguages = {
            astro = 'html',
          },
        },
        filetypes_exclude = { 'markdown' },
        filetypes_include = {},

        settings = {
          tailwindCSS = {
            classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
            includeLanguages = {
              elixir = 'html-eex',
              eelixir = 'html-eex',
              heex = 'html-eex',
              htmlangular = 'html',
              templ = 'html',
            },
          },
        },
      },
      setup = {
        tailwindcss = function(_, opts)
          opts.filetypes = opts.filetypes or {}

          -- Add default filetypes
          vim.list_extend(opts.filetypes, vim.lsp.config.tailwindcss.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft) return not vim.tbl_contains(opts.filetypes_exclude or {}, ft) end, opts.filetypes)

          -- Add additional filetypes
          vim.list_extend(opts.filetypes, opts.filetypes_include or {})
        end,
      },
      cssls = {
        filetypes = { 'css', 'scss', 'less' },
        init_options = { provideFormatter = true },
        single_file_support = true,
        settings = {
          css = {
            lint = {
              unknownAtRules = 'ignore',
            },
            validate = true,
          },
          scss = {
            lint = {
              unknownAtRules = 'ignore',
            },
            validate = true,
          },
          less = {
            lint = {
              unknownAtRules = 'ignore',
            },
            validate = true,
          },
        },
      },
    }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
})

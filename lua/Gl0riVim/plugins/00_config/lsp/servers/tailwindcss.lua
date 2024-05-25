local M = {}

M.cmd = { "tailwindcss-language-server", "--stdio" }

M.on_attach = function(client, bufnr)
  if client.server_capabilities.colorProvider then
    require("Gl0riVim.plugins.00_config.coding.lsp.utils.documentcolors").buf_attach(bufnr)
    require("colorizer").attach_to_buffer(bufnr, { mode = "background", css = true, names = false, tailwind = false })
  end
end

M.filetypes = {
  "aspnetcorerazor",
  "astro",
  "astro-markdown",
  "blade",
  "clojure",
  "django-html",
  "htmldjango",
  "edge",
  "eelixir",
  "elixir",
  "ejs",
  "erb",
  "eruby",
  "gohtml",
  "gohtmltmpl",
  "haml",
  "handlebars",
  "hbs",
  "html",
  "html-eex",
  "heex",
  "jade",
  "leaf",
  "liquid",
  "markdown",
  "mdx",
  "mustache",
  "njk",
  "nunjucks",
  "php",
  "razor",
  "slim",
  "twig",
  "css",
  "less",
  "postcss",
  "sass",
  "scss",
  "stylus",
  "sugarss",
  "javascript",
  "javascriptreact",
  "reason",
  "rescript",
  "typescript",
  "typescriptreact",
  "vue",
  "svelte",
}

M.init_options = {
  userLanguages = {
    eelixir = "html-eex",
    eruby = "erb",
  },
}

M.root_dir = function()
  local lspconfig_status, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_status then
    vim.notify("[lspconfig] failed to load within (00_config/lsp/servers/tailwindcss.lua)", vim.log.levels.WARN)
    return
  end
  lspconfig.util.root_pattern(
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts",
    "package.json",
    "node_modules",
    ".git"
  )
end

M.settings = {
  tailwindCSS = {
    classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
    lint = {
      cssConflict = "warning",
      invalidApply = "error",
      invalidConfigPath = "error",
      invalidScreen = "error",
      invalidTailwindDirective = "error",
      invalidVariant = "error",
      recommendedVariantOrder = "warning",
    },
    experimental = {
      classRegex = {
        "tw`([^`]*)",
        'tw="([^"]*)',
        'tw={"([^"}]*)',
        "tw\\.\\w+`([^`]*)",
        "tw\\(.*?\\)`([^`]*)",
        { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        { "classnames\\(([^)]*)\\)", "'([^']*)'" },
        { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
      },
    },

    validate = true,
  },
}

return M

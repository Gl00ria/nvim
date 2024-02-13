local M = {}

M.on_attach = function(client, bufnr)
  if client.server_capabilities.colorProvider then
    require("Gl0riVim.plugins.00_config.coding.lsp.utils.documentcolors").buf_attach(bufnr)
    require("colorizer").attach_to_buffer(bufnr, { mode = "background", css = true, names = false, tailwind = false })
  end
end

M.filetypes = { "html", "mdx", "javascript", "javascriptreact", "typescriptreact", "vue", "svelte" }

M.init_options = {
  userLanguages = {
    eelixir = "html-eex",
    eruby = "erb",
  },
}

M.settings = {
  tailwindCSS = {
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

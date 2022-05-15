local M = {}

M.setup = function(config, _, opts)
  local clangd = opts.cmd and opts.cmd or "clangd"
  local cmd = {
    clangd,
    "--query-driver=/usr/bin/g++",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "-j=5",
    "--malloc-trim",
    "--header-insertion=iwyu",
  }
  config.cmd = cmd
  return config
end

return M

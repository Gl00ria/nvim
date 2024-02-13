local M = {}

M.attach = function(client, buffer)
  local status_ok, inlayhints = pcall(require, "lsp-inlayhints")
  if not status_ok then
    vim.notify("[inlayhints] failed to load within (00_config.lsp.inlayhints.lua)", vim.log.levels.WARN)
    return
  end
  inlayhints.on_attach(client, buffer)
end

return M

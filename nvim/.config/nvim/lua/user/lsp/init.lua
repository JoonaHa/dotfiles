local M = {}

function M.init(language_servers)
  require('user.lsp.lspconfig').init(language_servers, false, require('user.completion.cmp').init().get_capabilites() )
  --require('user.lsp').init(language_servers, true, require('user.completion.coq').init().get_capabilites() )
  require('user.lsp.inlay-hints')
  return M
end

return M

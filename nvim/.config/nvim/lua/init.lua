require'lspconfig'
require('cmp').setup {
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cmdline' },
    { name = 'spell' },
  }
}
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require("mason").setup()
require("mason-lspconfig").setup()
require('luasnip')
 -- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

require('user.lsp')
require('user.treesitter')
require('user.telescope')
require('user.cmp')

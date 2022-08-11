local language_servers = {
    'rust_analyzer',
    'pyright',
    'tsserver',
    'sumneko_lua',
    --Scripting
    'bashls',
    -- Non programming languages
    'sqls',
    'texlab',
    'marksman',
    'jsonls',
    'yamlls',
    --xml
    'lemminx'
  }
require("which-key").setup()
require('luasnip')
 -- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

local capabilities_callback = require('user.completion.cmp').init().get_capabilites()

print(capabilities_callback)
require('user.lsp').init(language_servers, false, require("cmp_nvim_lsp").update_capabilities)
--require('user.completion.coq')

require('user.treesitter')
require('user.telescope')
require("user.mappings")
require("user.autopairing")
require("user.icons")
require("user.format")

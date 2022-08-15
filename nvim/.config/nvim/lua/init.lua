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
local nerdtree_grammar = {
    'lua',
    'typescript',
    'rust',
    'python',
    'latex',
    'typescript',
    'tsx',
    'javascript',
    --Scripting
    'bash',
    -- Non programming languages
    'bibtex',
    'markdown'
    }

local null_ls_tools = {
	"formatting.stylua",
	"diagnostics.eslint",
	"completion.spell",
	"formatting.rustfmt",
	"formatting.fixjson",
	"formatting.tidy",
}

require('luasnip')
 -- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()
require('user.lsp').init(language_servers, false, require('user.completion.cmp').init().get_capabilites() )
--require('user.lsp').init(language_servers, true, require('user.completion.coq').init().get_capabilites() )
require('user.treesitter').init(nerdtree_grammar)
require("user.formatting").init(null_ls_tools)

require("user.lualine")
require("user.icons")
require("user.nvim-tree")
require('user.telescope')
require("user.autopairing")
require("user.which-key")
require("user.mappings")

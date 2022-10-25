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
local treesitter_grammar = {
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
	'formatting.stylua',
	'diagnostics.eslint',
	'completion.spell',
	'formatting.rustfmt',
	'formatting.fixjson',
	'formatting.tidy',
}

require('impatient')
require('user.ui-plugins')
require('user.git-plugins')
require('project_nvim').setup()
require('luasnip')
require('project_nvim').setup()
require('dir-telescope').setup({
      hidden = true,
      respect_gitignore = false,
    })
 -- Load friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()
require('user.formatting').init(null_ls_tools)
require('user.lsp').init(language_servers)
require('user.treesitter').init(treesitter_grammar).enableContextHeader()

require('user.icons')
require('user.nvim-tree')
require('user.telescope')
require('user.autopairing')
require('user.which-key')
require('user.mappings')
require('user.illuminate')


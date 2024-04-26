local language_servers = {
    'rust_analyzer',
    'pyright',
    'tsserver',
    'lua_ls',
    --Scripting
    'bashls',
    -- Non programming languages
    'sqlls',
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
    'latex',
    'markdown'
    }

local null_ls_tools = {
	'formatting.stylua',
	'completion.spell',
	'formatting.tidy',
	'diagnostics.pylint',
	'formatting.black',
	'formatting.prettier'
}

require('user.ui-plugins')
require('user.git-plugins')
require('project_nvim').setup()
require('luasnip')
require('ibl').setup()
require('dir-telescope').setup({
      hidden = true,
      respect_gitignore = false,
    })
require('netrw').setup()
 -- Load friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()
require('user.formatting').init(null_ls_tools)
require('user.lsp').init(language_servers)
require('user.treesitter')
    .init(treesitter_grammar)
    .enableContextHeader()
    .enable_rainbow()

require('user.icons')
require('user.nvim-tree')
require('user.telescope')
require('user.autopairing')
require('user.which-key')
require('user.illuminate')


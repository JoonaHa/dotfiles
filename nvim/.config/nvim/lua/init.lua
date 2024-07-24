local language_servers = {
    'rust_analyzer',
    'pyright',
    'tsserver',
    'lua_ls',
    --Scripting
    'bashls',
    'terraformls',
    -- Non programming languages
    'sqlls',
    'texlab',
    'marksman',
    'jsonls',
    'yamlls',
    'helm_ls',
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
    'terraform',
    -- Non programming languages
    'sql',
    'bibtex',
    'latex',
    'markdown',
    'helm',
    'yaml',
    }

local null_ls_tools = {
	'formatting.stylua',
	'completion.spell',
	'formatting.tidy',
	'diagnostics.pylint',
	'formatting.black',
	'formatting.prettier',
    'diagnostics.terraform_validate',
    'formatting.terraform_fmt'
}

require('user.ui-plugins')
require('user.git-plugins')
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


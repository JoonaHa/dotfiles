return {
  language_servers = {
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
  },
  treesitter_grammar = {
    'lua',
    'vim',
    'vimdoc',
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
    'yaml'
  },
  null_ls_tools = {
    mason = {
      'sylua',
      'tidy',
      'pylint',
      'black',
      'prettier',
      'terraform_ls'
    },
    null_ls = {
      'builtins.completion.spell',
    }
  }
}

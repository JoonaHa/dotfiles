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
    'formatting.stylua',
    'completion.spell',
    'formatting.tidy',
    'diagnostics.pylint',
    'formatting.black',
    'formatting.prettier',
    'diagnostics.terraform_validate',
    'formatting.terraform_fmt'
  }
}

vim.cmd([[
  set termguicolors

  colorscheme kanagawa
  let g:material_style = 'darker'
  "hi CursorColumn guibg=#856262
  "hi Visual gui=none guifg=none guibg=#4d3f3f

  set cursorline 
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark

  "nvim-cmp groups
  "See https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
  " gray
  "highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  "" blue
  "highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  "highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  "" light blue
  "highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  "highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  "highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  "" pink
  "highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  "highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  "" front
  "highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  "highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  "highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4

]])

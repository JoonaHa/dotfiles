" ========== Vim Basic Settings ============="
" Execute local .vimrc securely when started from whitelisted directory
" https://vimtricks.com/p/local-vimrc-files
if getcwd() =~# '^(\/home\/mina\/Projektit\/dotfiles\/)'
  set secure exrc
endif

set mouse=a
set mousefocus
set mousehide
set mousemodel=popup_setpos
set encoding=UTF-8
set updatetime=50
" replace tab with spaces
set tabstop=4
set shiftwidth=4
set expandtab
set nocompatible
set hlsearch
set number
set ignorecase
set smartcase
syntax enable
filetype plugin indent on
set showmatch
set autoindent
set smartindent
set nowrap
set backspace=indent,eol,start " make backspace work like most other programs
:inoremap jk <esc>
"" Change map leader to space
nnoremap <SPACE> <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
set ruler
set showcmd
set laststatus=2
set foldmethod=syntax
set nofoldenable
set relativenumber
set splitright
filetype plugin on
if has('win32')
  set nofsync
  let $PATH = "C:\Program Files\Git\usr\bin;" . $PATH
endif

"Spelling
set spelllang=en_us
let g:vimchant_spellcheck_lang = 'fi'
" Toggle between finnish and english spelling
let g:finnish_on = 0
function! ToggleFinnish()
  if &spell == 0
    echo 'Spelling not active. Run :set spell'
    return
  endif
  if g:loaded_vimchant == 0
    echo 'Vimchant is not loaded'
    return
  endif
  if g:finnish_on == 0
    VimchantSpellCheckOn
    let g:finnish_on = 1
  else
    VimchantSpellCheckOff
    let g:finnish_on = 0
  endif
endfunction
command Suomi call ToggleFinnish()
"https://vimtricks.com/p/word-wrapping/
"https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping 
function! ToggleWrap()
  if &wrap
    setlocal nowrap nolinebreak
    unmap j
    unmap <Down>
    unmap k
    unmap <Up>
    unmap 0
    unmap ^
    unmap $
  else
    setlocal wrap linebreak
    nnoremap j gj
    nnoremap <Down> gj
    nnoremap k gk
    nnoremap <Up> gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap <Down> gj
    vnoremap k gk
    vnoremap <Up> gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
  endif
endfunction
command WrapToggle call ToggleWrap()

function WritingSettingsToggle()
  if &spell
    setlocal nospell
  else
    setlocal spell
  endif
  WrapToggle
endfunction
command WritingToggle call WritingSettingsToggle()

" Writing autocommands
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md,*.txt,*.tex call WritingSettingsToggle()
autocmd FileType gitcommit call WritingSettingsToggle()
"Autoread on bufenter
au FocusGained,BufEnter * :checktime
"Help mappings
"https://vim.fandom.com/wiki/Learn_to_use_help
"Press Enter to jump to the subject (topic) under the cursor.
"Press Backspace to return from the last jump.
"Press s to find the next subject, or S to find the previous subject.
"Press o to find the next option, or O to find the previous option.
autocmd FileType help nnoremap <buffer> <CR> <C-]>
autocmd FileType help nnoremap <buffer> <BS> <C-T>
autocmd FileType help nnoremap <buffer> o /'\l\{2,\}'<CR>
autocmd FileType help nnoremap <buffer> O ?'\l\{2,\}'<CR>
autocmd FileType help nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
autocmd FileType help nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>

" =================PLUGINS================
call plug#begin()
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} | 
      \ Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
"Cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'f3fora/cmp-spell'
Plug 'ray-x/cmp-treesitter'
Plug 'uga-rosa/cmp-dictionary'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'kdheepak/cmp-latex-symbols'
" Coq
"Plug 'ms-jpq/coq_nvim', {'branch': 'coq','do': 'python3 -m coq deps'}
"Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
"Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
" Must have plugings
Plug 'ahmedkhalf/project.nvim'
Plug 'liuchengxu/vista.vim'
Plug 'nvim-lualine/lualine.nvim' |
      \ Plug 'kdheepak/tabline.nvim' |
      \ Plug 'arkav/lualine-lsp-progress'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-telescope/telescope-fzf-native.nvim', 
      \ { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release 
        \ && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'SmiteshP/nvim-navic'
" Tools
Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'lewis6991/impatient.nvim'
"Plug 'baverman/vial'
"Plug 'baverman/vial-http'
"Plug 'airblade/vim-rooter'
Plug 'machakann/vim-highlightedyank'
Plug 'luochen1990/rainbow'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'gko/vim-coloresque'
Plug 'RRethy/vim-illuminate'
Plug 'folke/which-key.nvim'
Plug '~/.config/nvim/plugged/vimchant'
" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" Themes
Plug 'rebelot/kanagawa.nvim' " Vim-Plug
Plug 'EdenEast/nightfox.nvim' " Vim-Plug
Plug 'marko-cerovac/material.nvim'
Plug 'jacoborus/tender.vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'onsails/lspkind.nvim'
Plug 'rakr/vim-one'

" Snippets
"Plug 'SirVer/ultisnips'
Plug 'rafamadriz/friendly-snippets'
Plug 'sheerun/vim-polyglot'
" Snippets/LSP
 Plug 'L3MON4D3/LuaSnip'
 Plug 'saadparwaiz1/cmp_luasnip'

" Languages
Plug 'dbakker/vim-lint'
Plug 'rust-lang/rust.vim'
Plug 'cjrh/vim-conda'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm ci'  }
Plug 'lervag/vimtex'
call plug#end()

lua require("init")

" =================KEYBINDS================
nmap <leader>hs :split<Return><C-w>w
nmap <leader>vs :vsplit<Return><C-w>w
nmap <leader>hS :new<Return><C-w>w
nmap <leader>vS :vnew<Return><C-w>w

:nnoremap <silent><esc> :noh<CR>
:nnoremap <esc>[ <esc>[
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

tnoremap <A-Up> <C-\><C-n><C-w>h
tnoremap <A-Down> <C-\><C-n><C-w>j
tnoremap <A-Left> <C-\><C-n><C-w>k
tnoremap <A-Right> <C-\><C-n><C-w>l
nnoremap <silent> <A-Up> <C-w>h
nnoremap <silent> <A-Down> <C-w>j
nnoremap <silent> <A-Left> <C-w>k
nnoremap <silent> <A-Right> <C-w>l

nmap <silent> ]t gt
nmap <silent> [t gT
nmap <silent> <Tab> gt
nmap <silent> <S-Tab> gT
nmap <silent> <A-n> :tabnew<CR>
nmap <silent> <A-w> :tabclose<CR>

nmap <silent> ]b :bnext<CR>
nmap <silent> [b :bprev<Cr>
" Move line up or down
nnoremap <C-S-Down> :m .+1<CR>==
nnoremap <C-S-Up> :m .-2<CR>==
inoremap <C-S-Down> <Esc>:m .+1<CR>==gi
inoremap <C-S-Up>  <Esc>:m .-2<CR>==gi
vnoremap <C-S-Down> :m '>+1<CR>gv=gv
vnoremap <C-S-Up>  :m '<-2<CR>gv=gv
nnoremap <C-S-j> :m .+1<CR>==
nnoremap <C-S-k> :m .-2<CR>==
inoremap <C-S-j> <Esc>:m .+1<CR>==gi
inoremap <C-S-k> <Esc>:m .-2<CR>==gi
vnoremap <C-S-j> :m '>+1<CR>gv=gv
vnoremap <C-S-k> :m '<-2<CR>gv=gv

" Visual search in /
vmap / y/<C-R>"<CR>

"Splite sizing
nnoremap <A-<> <C-w><
nnoremap <A->> <C-w>>
nnoremap <A-+> <C-w>+
nnoremap <A--> <C-w>-

" Primagen leader paste yank
xnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Incerement/decrement to alt keys
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>
vnoremap <A-a> <C-a>
vnoremap <A-x> <C-x>
vnoremap g<A-a> g<C-a>
vnoremap g<A-x> g<C-x>

" Remap backtick
nmap å `

" Center cursor when scrolling up or down
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
" System Clipboard and select all
vnoremap <C-c> "+y
vnoremap <C-x> "+d
map <C-v> "+p
map <C-s> :w<CR>
map <C-a> ggVG
" WSL clipboard
"if has('wsl')
"    let s:clip = '/mnt/c/Windows/System32/clip.exe'
"    augroup Yank
"        autocmd!
"        autocmd TextYankPost * call system('/mnt/c/Windows/System32/clip.exe ',@")"autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
"    augroup END
"    noremap "+P :r!/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command Get-Clipboard<CR>
"endif
"
"=================Languages================
let g:rustfmt_file_lines = 1
let g:syntastic_python_checkers = ['pylint']
let g:python_host_prog = "/usr/bin/python2"

"=================THEMES================
"Credit joshdick
""Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX
"check and use tmux's 24-bit color support
""(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 <https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

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

"=================Hexmode================"
" ex command for togling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries
    "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
"=================Neovide================"
if exists('g:neovide')
  if has('win32')
    set guifont=Cascadia\ Code\ PL,CaskaydiaCove\ NF,CaskaydiaCove\ Nerd\ Font,Iosevka:h12
  endif
  let g:neovide_cursor_animation_length=0
  let g:neovide_cursor_trail_length=0
  let g:neovide_remember_window_size = v:true

    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <C-_> :set guifont=+<CR>
    nnoremap <C--> :set guifont=-<CR>
endif
"=================Nvim-tree================"
map <C-n> :NvimTreeToggle<CR>
nmap tf :NvimTreeFindFile<CR>
"=================Telescope================"
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
"====MarkdownPreview====="
" " set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 1

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
      \ 'mkit': {},
      \ 'katex': {},
      \ 'uml': {},
      \ 'maid': {},
      \ 'disable_sync_scroll': 0,
      \ 'sync_scroll_type': 'middle',
      \ 'hide_yaml_meta': 1,
      \ 'sequence_diagrams': {},
      \ 'flowchart_diagrams': {},
      \ 'content_editable': v:false,
      \ 'disable_filename': 0
      \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

"=================Vista==============
map <C-p> :Vista!!<CR>
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'nvim_lsp'
let g:vista#finders = ['fzf']
let g:vista_fzf_preview = ['right:50%']
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1
let g:vista_vimwiki_executive = 'markdown'
" Use the markdown extension for vimwiki and pandoc filetype.
let g:vista_executive_for = {
      \ 'vimwiki': 'markdown',
      \ 'pandoc': 'markdown',
      \ 'markdown': 'toc',
      \ }
" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
      \   "function": "\uf794",
      \   "variable": "\uf71b",
      \  }

"=================Vimtex==============
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'
autocmd VimEnter *.tex VimtexCompile
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
nnoremap <localleader>lt :call vimtex#fzf#run()<cr>
" =================Rainbow (brackets)==============
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowTogglelet g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
" =================Indent Guides==============
let g:indent_guides_enable_on_vim_startup = 1
" =================Luasnip==============
" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

" ========== Vim Basic Settings =============" "" Execute local .vimrc securely when started from whitelisted directory
"" https://vimtricks.com/p/local-vimrc-files
"if getcwd() =~# '^(\/home\/mina\/Projektit\/dotfiles\/)'
"  set secure exrc
"endif
"
set termguicolors
set cursorline 
set winblend=0
set wildoptions=pum
set pumblend=5
set background=dark

set mouse=a
set mousefocus
set mousehide
set mousemoveevent
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
" make backspace work like most other programs
set backspace=indent,eol,start
inoremap jk <esc>
"" Change map leader to space
nnoremap <SPACE> <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
set ruler
set showcmd
set laststatus=3
set foldmethod=syntax
set nofoldenable
set relativenumber
set splitright
set signcolumn=yes:1
if has('win32')
  set nofsync
  let $PATH = "C:\Program Files\Git\usr\bin;" . $PATH
endif
" Easier visual macro execution
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

"Spelling
set spelllang=en_us
let g:vimchant_spellcheck_lang = 'fi'
" Toggle between finnish and english spelling
let g:finnish_on = 0
let g:spell_status = 0
function! ToggleFinnish()
  if g:loaded_vimchant == 0
    echo 'Vimchant is not loaded'
    return
  endif
  if g:finnish_on == 0
    VimchantSpellCheckOn
    let g:finnish_on = 1
    let g:spell_status = &spell
    setlocal nospell
  else
    VimchantSpellCheckOff
    let g:finnish_on = 0
    let &spell = g:spell_status
  endif
endfunction
command Suomi call ToggleFinnish()
"https://vimtricks.com/p/word-wrapping/
"https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping 
function! ToggleWrap()
  if &wrap
    setlocal nowrap nolinebreak
    unmap <buffer> j
    unmap <buffer> <Down>
    unmap <buffer> k
    unmap <buffer> <Up>
    unmap <buffer> 0
    unmap <buffer> ^
    unmap <buffer> $
  else
    setlocal wrap linebreak
    " If [count] is used use normal linewise navigation to ensure thaht
    " relative linenumbers can still be used for navication.
    " Without [count] use display line navigation
    nnoremap <buffer> <expr> j v:count == 0 ? 'gj' : "\<Esc>".v:count.'j'
    nnoremap <buffer> <expr> <Down> v:count == 0 ? 'gj' : "\<Esc>".v:count.'j'
    nnoremap <buffer> <expr> k v:count == 0 ? 'gk' : "\<Esc>".v:count.'k'
    nnoremap <buffer> <expr> <Up> v:count == 0 ? 'gk' : "\<Esc>".v:count.'k'
    nnoremap <buffer> 0 g0
    nnoremap <buffer> ^ g^
    nnoremap <buffer> $ g$
    vnoremap <buffer> <expr> j v:count == 0 ? 'gj' : "\<Esc>".v:count.'j'
    vnoremap <buffer> <expr> <Down> v:count == 0 ? 'gj' : "\<Esc>".v:count.'j'
    vnoremap <buffer> <expr> k v:count == 0 ? 'gk' : "\<Esc>".v:count.'k'
    vnoremap <buffer> <expr> <Up> v:count == 0 ? 'gk' : "\<Esc>".v:count.'k'
    vnoremap <buffer> 0 g0
    vnoremap <buffer> ^ g^
    vnoremap <buffer> $ g$
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
" Vimtex here because currently none-ls breaks g:vimtex_view_method
"=================Vimtex==============
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'
autocmd VimEnter *.tex VimtexCompile
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
nnoremap <localleader>lt :call vimtex#fzf#run()<cr>

lua require("init")

" =================KEYBINDS================

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

nmap <leader>hs :split<Return><C-w>w
nmap <leader>vs :vsplit<Return><C-w>w
nmap <leader>hS :new<Return><C-w>w
nmap <leader>vS :vnew<Return><C-w>w

nnoremap <silent><esc> :noh<CR>
nnoremap <esc>[ <esc>[

nmap <silent> ]t gt
nmap <silent> [t gT
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
nnoremap <C-b> <C-b>zz
nnoremap <C-f> <C-f>zz
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
"Neovide doestn't source ginit.vim
if exists('g:neovide')
  runtime ginit.vim
endif
"=================THEMES================

colorscheme kanagawa
let g:material_style = 'darker'
"hi CursorColumn guibg=#856262
"hi Visual gui=none guifg=none guibg=#4d3f3f



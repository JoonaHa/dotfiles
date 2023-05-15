" Enable Mouse
set mouse=a
set mousefocus
set mousehide
set mousemoveevent
set mousemodel=popup_setpos
inoremap <C-S-V> <C-r>+
cnoremap <C-S-V> <C-r>+



" Set Editor Font
if has('win32')
  set guifont=CaskaydiaCove\ Nerd\ Font:h12
  " Use GuiFont! to ignore font errors
  if exists(':GuiFont')
    GuiFont! CaskaydiaCove Nerd Font:h12
  endif
endif
"Change GUI font size
"See https://github.com/vim-scripts/zoom.vim
"Plugin loaded in init.vim
nnoremap <silent> <C-ScrollWheelUp> :ZoomIn<CR>
nnoremap <silent> <C-ScrollWheelDown> :ZoomOut<CR>
nnoremap <silent> <C-+> :ZoomIn!<CR>
nnoremap <silent> <C--> :ZoomOut!<CR>
nnoremap <silent> <C-=> :ZoomReset!<CR>


if exists('*GuiShowContextMenu')
  " Right Click Context Menu (Copy-Cut-Paste)
  nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
  inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
  xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
  snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
endif
" Disable GUI Tabline
if exists(':GuiTabline')
  GuiTabline 0
endif
" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
  GuiPopupmenu 0
endif
" Enable GUI ScrollBar
"if exists(':GuiScrollBar')
"    GuiScrollBar 1
"endif
"
if exists(':GuiAdaptiveColor')
  GuiAdaptiveColor 1
endif
if exists(':GuiAdaptiveFont')
  GuiAdaptiveFont 1
endif

if exists('g:fvim_loaded')
  " good old 'set guifont' compatibility with HiDPI hints...
  if g:fvim_os == 'windows' || g:fvim_render_scale > 1.0
    set guifont=Cascadia\ Code\ PL:h12
  else
    set guifont=Cascadia\ Code\ PL:h26
  endif
  FVimCustomTitleBar v:true 
  FVimFontAutoSnap v:true
  nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif

if exists('g:neovide')
  let g:neovide_cursor_animation_length=0
  let g:neovide_cursor_trail_length=0
  let g:neovide_remember_window_size = v:true
  let g:neovide_confirm_quit = v:true


  let g:neovide_scale_factor=1.0
  function! ChangeScaleFactor(delta)
    let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
  endfunction
  nnoremap <expr><C-ScrollWheelUp> ChangeScaleFactor(1.25)
  nnoremap <expr><C-ScrollWheelDown> ChangeScaleFactor(1/1.25)
  "Neovide problems with Ctrl mappings
  nnoremap <expr><C-å> ChangeScaleFactor(1.25)
  nnoremap <expr><C--> ChangeScaleFactor(1/1.25)
endif

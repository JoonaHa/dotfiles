" Enable Mouse
set mouse=a

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont! Cascadia Code PL:h12
    " good old 'set guifont' compatibility with HiDPI hints...
    if g:fvim_os == 'windows' || g:fvim_render_scale > 1.0
      set guifont=Cascadia\ Code\ PL:h12
    else
      set guifont=Cascadia\ Code\ PL:h12
    endif
      
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

if exists('g:neovide_cursor_animation_length')
  let g:neovide_cursor_animation_length=0
  let g:neovide_cursor_trail_length=0
  let g:neovide_remember_window_size = v:true
endif

if exists('g:fvim_loaded')
    FVimCustomTitleBar v:true 
    FVimFontAutoSnap v:true
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif

    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <C-_> :set guifont=+<CR>
    nnoremap <C--> :set guifont=-<CR>
" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

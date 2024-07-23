return {
  "christoomey/vim-tmux-navigator",
  init = function()
    vim.cmd([[

      let g:tmux_navigator_no_mappings = 1

      noremap <silent> <A-h> :<C-U>TmuxNavigateLeft<cr>
      noremap <silent> <A-j> :<C-U>TmuxNavigateDown<cr>
      noremap <silent> <A-k> :<C-U>TmuxNavigateUp<cr>
      noremap <silent> <A-l> :<C-U>TmuxNavigateRight<cr>
      noremap <silent> <A-+> :<C-U>TmuxNavigatePrevious<cr>

    ]])
  end,
}

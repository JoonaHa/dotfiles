return {
  "vim-scripts/Vimchant",
  init = function()
    vim.cmd([[
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
    ]])
  end,
}

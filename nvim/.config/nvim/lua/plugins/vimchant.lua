return {
  "vim-scripts/Vimchant",
  init = function()
    vim.cmd([[
      let g:vimchant_spellcheck_lang = 'fi'
      " Toggle between finnish and english spelling
      let g:finnish_on = 0
      let g:spell_status = 0
    ]])
  end,
}

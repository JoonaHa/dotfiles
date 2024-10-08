return {
  "liuchengxu/vista.vim",
  cmd = "Vista",
  keys = {
   { "<C-p>", "<cmd>Vista!!<cr>", desc = "Vista" },
  },
  init = function()
    vim.cmd([[
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

    ]])
  end,
}

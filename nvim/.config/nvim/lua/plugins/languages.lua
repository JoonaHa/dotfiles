return {
  {
    "rust-lang/rust.vim",
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.rustfmt_file_lines = 1
    end
  },
  "preservim/vim-markdown",
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.tex_flavor='latex'
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_quickfix_mode=0
      vim.o.conceallevel = 1
      vim.g.tex_conceal='abdmg'
    end
  }
}

return {
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    config = function()

      require('gitsigns').setup{
        signcolumn = false,
        numhl = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 400,
          ignore_whitespace = false,
          },
      }
    end
  },
  "sindrets/diffview.nvim",
}

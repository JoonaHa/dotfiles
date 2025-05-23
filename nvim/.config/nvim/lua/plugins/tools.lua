return {
  "tpope/vim-surround",
  "tpope/vim-sleuth",
  "godlygeek/tabular",
  "michaeljsmith/vim-indent-object",
  {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equalent to setup({}) function
  },
  "machakann/vim-highlightedyank",
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require'colorizer'.setup()
    end,
  },
  {"RRethy/vim-illuminate", commit="19cb21f513fc2b02f0c66be70107741e837516a1"},
}

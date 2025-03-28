return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  ft = { 'markdown', 'quarto', 'latex' },
  keys = {
    { '<leader>ii', '<cmd>PasteImage<cr>', desc = 'insert [i]mage from clipboard' },
  },
  opts = {
    filetypes = {
      markdown = {
        url_encode_path = true,
        drag_and_drop = {
          download_images = false,
        },
      },
      quarto = {
        url_encode_path = true,
        template = '![$CURSOR]($FILE_PATH)',
        drag_and_drop = {
          download_images = false,
        },
      },
    }
  }
}

return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
    ft = { 'markdown', 'quarto', 'latex' },
      filetypes = {
        markdown = {
          url_encode_path = true,
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    config = function(_, opts)
      require('img-clip').setup(opts)
      vim.keymap.set('n', '<leader>ii', ':PasteImage<cr>', { desc = 'insert [i]mage from clipboard' })
    end,
}

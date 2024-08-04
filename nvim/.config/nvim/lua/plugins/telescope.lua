return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "princejoogie/dir-telescope.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release " ..
          "&& cmake --build build --config Release"
      }
    },

    config = function()

        require('dir-telescope').setup({
          hidden = true,
          respect_gitignore = false,
        })

          local telescope = require("telescope")
          telescope.setup{
            defaults = {
              prompt_prefix = " ",
              selection_caret = "❯ ",
              path_display = { "truncate" },
              color_devicons = true,
              selection_strategy = "reset",
              sorting_strategy = "ascending",
              layout_strategy = "horizontal",
              layout_config = {
                horizontal = {
                  prompt_position = "top",
                  preview_width = 0.55,
                  results_width = 0.8,
                },
                vertical = {
                  mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
              },
            }
          }
          telescope.load_extension("fzf")
          telescope.load_extension("dir")

         local builtin = require('telescope.builtin')
         vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
         vim.keymap.set('n', '<leader>tg', builtin.git_files, {})
         vim.keymap.set('n', '<leader>ts', builtin.live_grep, {})
         vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
         vim.keymap.set('n', '<leader>tdf', require("telescope").extensions.dir.find_files, {})
         vim.keymap.set('n', '<leader>tds', require("telescope").extensions.dir.live_grep, {})

    end,
}

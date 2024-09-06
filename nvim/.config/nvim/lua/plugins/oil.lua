return {
  'stevearc/oil.nvim',
  keys = {
    {"<C-n>", "<CMD>Oil --float<CR>", { desc = "Open parent directory in oil float" } }
  },
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    require("oil").setup({
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
      -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
      default_file_explorer = false,
    })
  end
}

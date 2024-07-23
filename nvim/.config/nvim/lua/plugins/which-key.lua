return {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup {
      plugins = {
        marks = true,
        registers = true,
        presets = false,
        spelling = true
      }
    }
  end,
}

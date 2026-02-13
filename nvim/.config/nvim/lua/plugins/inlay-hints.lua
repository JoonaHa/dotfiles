return {
  {
    "MysticalDevil/inlay-hints.nvim",
    event = "LspAttach",
    dependencies = { "neovim/nvim-lspconfig" }, -- optional
    config = function()
      require("inlay-hints").setup()
    end,
  },
}

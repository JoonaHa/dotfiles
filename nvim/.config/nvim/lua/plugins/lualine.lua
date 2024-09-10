return
  {
      "nvim-lualine/lualine.nvim",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        "arkav/lualine-lsp-progress",
        {
          "SmiteshP/nvim-navic",
          dependencies = { "neovim/nvim-lspconfig" },
        },
      },
      config = function ()
         require('user.ui-plugins').init()
      end
      }

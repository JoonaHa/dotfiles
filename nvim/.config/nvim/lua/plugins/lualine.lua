return
  {
      "nvim-lualine/lualine.nvim",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        "arkav/lualine-lsp-progress",
        {
          "SmiteshP/nvim-navic",
          dependencies = { "neovim/nvim-lspconfig" },
          commit = "8649f694d3e76ee10c19255dece6411c29206a54"
        },
      },
      config = function ()
         require('user.ui-plugins').init()
      end
      }

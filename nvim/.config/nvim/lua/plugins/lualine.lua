return
  {
      "nvim-lualine/lualine.nvim",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
        "arkav/lualine-lsp-progress"
      },
      config = function ()
        local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed
            }
          end
        end
        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {},
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
              statusline = 1000,
              tabline = 1000,
              winbar = 1000,
            }
          },
          sections = {
            lualine_a = {'mode'},
            lualine_b = {
              'branch',
              {'diff', source = diff_source},
            },
            lualine_c = {
              {
                'filename',
                file_status = true, -- displays file status (readonly status, modified status)
                path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
              },
            'lsp_progress'
            },
            lualine_x = {'diagnostic', 'encoding', 'fileformat', 'filetype'},
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {
              {
                'filename',
                file_status = true, -- displays file status (readonly status, modified status)
                path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
              }
            },
            lualine_x = {'diagnostic', 'encoding', 'fileformat', 'filetype'},
            lualine_z = { 'location' },
          },

          winbar = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { navic_wrapper },
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
          },

          inactive_winbar = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { navic_wrapper },
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
          },

          extensions = { 'fugitive' ,'nerdtree', 'symbols-outline', 'neo-tree' }
        }

        vim.opt.termguicolors = true
          end
      }

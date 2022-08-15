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
local function window()
  return vim.api.nvim_win_get_number(0)
end
local function treesitter()
  local location = require('nvim-treesitter').statusline{
      indicator_size = vim.o.columns * 2 / 3,
      type_patterns = {'class', 'function', 'method'},
     -- separator = '  ',
    }
  if location ~= nil then return location else return "" end
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox-material',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
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
    lualine_c = { treesitter },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },

  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { treesitter },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },

  extensions = { 'fugitive' ,'nerdtree', 'symbols-outline', 'neo-tree' }
}

require'tabline'.setup {
  -- Defaults configuration options
  enable = true,
  options = {
    show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
    show_devicons = true, -- this shows devicons in buffer section
    show_bufnr = true, -- this appends [bufnr] to buffer section,
    show_filename_only = false, -- shows base filename only instead of relative path in filename
    show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
  }
}
    vim.cmd[[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
    ]]


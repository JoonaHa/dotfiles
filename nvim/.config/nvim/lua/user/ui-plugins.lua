local M = {}

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
--local function treesitter()
--  local location = require('nvim-treesitter').statusline{
--      indicator_size = vim.o.columns * 2 / 3,
--      type_patterns = {'class', 'function', 'method'},
--      separator = "    ",
--    }
--    if location ~= nil and  string.len(location) > 0 then
--      return vim.fn.expand('%:t') .. "  " .. location
--    else return vim.fn.expand('%:t')
--    end
--end


local navic = require('nvim-navic')
navic.setup{
      highlight = true,
      separator = " " .. "" .. "  ",
      depth_limit = 0,
      depth_limit_indicator = "..",
}
local function navic_wrapper()
  local location = navic.get_location()
    if location ~= nil and string.len(location) > 0 then
      return location
    else return '%#NavicIconsFile# %*%#NavicText#' .. vim.fn.expand('%:t') .. '%*'
    end
end

function M.lsp_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
      require('nvim-navic').attach(client, bufnr)
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
require("bufferline").setup{
  options = {
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
      end,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_buffer_default_icon = true,
    numbers = function(opts)
      return string.format('%s', opts.raise(opts.id))
    end,
  }
}
return M

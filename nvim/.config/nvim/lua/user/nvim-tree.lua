local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  print("Nvim-tree failed to load: " .. nvim_tree)
  return
end

local function custom_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'c', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', 'P', function()
    local node = api.tree.get_node_under_cursor()
    print(node.absolute_path)
  end, opts('Print Node Path'))

end

nvim_tree.setup {
  on_attach = custom_on_attach,
  sort_by = "case_sensitive",
  hijack_directories = {
    enable = true,
  },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
  -- update_to_buf_dir = {
  --   enable = false,
  -- },
  disable_netrw = false,
  hijack_netrw = false,
  update_cwd = true,

  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = true,
    highlight_opened_files = "icon",
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
  },
  diagnostics = {
    enable = true,
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },

  view = {
    adaptive_size = true,
    hide_root_folder = false,
    side = "left",
    number = false,
    relativenumber = false,
  },
}

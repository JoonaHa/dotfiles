local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  print("Nvim-tree failed to load: " .. nvim_tree)
  return
end

nvim_tree.setup {
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
  open_on_setup = false,
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
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, action ="edit" },
        { key = "c", action ="close_node" },
        { key = "v", action="vsplit" },
      },
    },
    number = false,
    relativenumber = false,
  },
}

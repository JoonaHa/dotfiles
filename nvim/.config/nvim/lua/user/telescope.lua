local telescope = require('telescope')
telescope.load_extension('projects')
telescope.setup{
  defaults = {
    prompt_prefix = " ",
    selection_caret = "❯ ",
    path_display = { "truncate" },
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },

    file_previewer = require'telescope.previewers'.cat.new,
    grep_previewer = require'telescope.previewers'.vimgrep.new,
    qflist_previewer = require'telescope.previewers'.qflist.new,
  }
}



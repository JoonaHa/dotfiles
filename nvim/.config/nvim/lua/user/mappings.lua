local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

map('n', ']d', vim.diagnostic.goto_next)
map('n', '<leader>df', vim.diagnostic.open_float)
map('n', '<leader>dl', vim.diagnostic.setloclist)

-- Create a command `:Format` local to the LSP buffer

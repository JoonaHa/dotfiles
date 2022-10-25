local M = {}

local lsp_inlayhints = require('lsp-inlayhints')
lsp_inlayhints.setup()

function M.lsp_attach(client, bufnr)
    lsp_inlayhints.on_attach(client, bufnr, false)
    vim.api.nvim_buf_create_user_command(
      bufnr,
      'LspInlayhintsToggle',
      function() lsp_inlayhints.toggle() end,
      { desc = 'Toggle Lsp-inlayhints for current buffer' }
    )
    vim.api.nvim_buf_create_user_command(
      bufnr,
      'LspInlayhintsReset',
      function() lsp_inlayhints.reset() end,
      { desc = 'Reset Lsp-inlayhints for current buffer' }
    )
end

return M

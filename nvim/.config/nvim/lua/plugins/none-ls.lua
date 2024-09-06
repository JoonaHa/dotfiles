return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
    "gbprod/none-ls-shellcheck.nvim",
  },
  config = function()
    require("mason-null-ls").setup({
        ensure_installed = require('variables').null_ls_tools.mason
    })

    -- If not supported by Mason. Use null-ls
    local formatters = require("variables").null_ls_tools.null_ls
    local builtin_sources = {}
    for _, x in ipairs(formatters) do
        local callable = "return require('null-ls')." .. x
        --for w in x:gmatch('a%+') do table.insert(fields, w) end
         table.insert(builtin_sources, load(callable)())
    end

    require("null-ls").setup({
        sources = builtin_sources,
    })
  end,
}

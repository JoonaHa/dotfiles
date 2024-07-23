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
    local formatters = require("variables").null_ls_tools
    local builtin_sources = {}
    for _, x in ipairs(formatters) do
        local callable = "return require('null-ls').builtins." .. x
        --for w in x:gmatch('a%+') do table.insert(fields, w) end
         table.insert(builtin_sources, load(callable)())
    end

    --table.foreach(formatters, function(i,x) formatters[i] = require('null-ls').builtins[x] end)
    require("null-ls").setup({
        sources = builtin_sources,
    })
  end,
}

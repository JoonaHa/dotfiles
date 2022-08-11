require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.diagnostics.eslint,
        require("null-ls").builtins.completion.spell,
        require("null-ls").builtins.formatting.rustfmt,
        require("null-ls").builtins.formatting.fixjson,
        require("null-ls").builtins.formatting.tidy,
    },
})

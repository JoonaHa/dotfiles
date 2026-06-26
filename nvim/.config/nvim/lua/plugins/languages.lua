return {
  {
    "rust-lang/rust.vim",
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.rustfmt_file_lines = 1
    end
  },
  "preservim/vim-markdown",
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- See https://github.com/iamcco/markdown-preview.nvim/issues/690
    build = ":call mkdp#util#install()",
    init = function()
        ---Fixes "No command :MarkdownPreview"
        ---https://github.com/iamcco/markdown-preview.nvim/issues/585#issuecomment-1724859362
        local function load_then_exec(cmd)
          return function()
            vim.cmd.delcommand(cmd)
            require("lazy").load({ plugins = { "markdown-preview.nvim" } })
            vim.api.nvim_exec_autocmds("BufEnter", {}) -- commands appear only after BufEnter
            vim.cmd(cmd)
          end
        end

        for _, cmd in pairs({ "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" }) do
          vim.api.nvim_create_user_command(cmd, load_then_exec(cmd), {})
        end
    end
  },
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.tex_flavor='latex'
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_quickfix_mode=0
      vim.o.conceallevel = 1
      vim.g.tex_conceal='abdmg'
    end
  },
  {
    "towolf/vim-helm",
    ft = "helm"
  }
}

return
{
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release.
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type or field for details.
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      -- Recommended/example keymaps.
      vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end,
        { desc = "Ask opencode…" })
      vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end,
        { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<leader>ot", function() require("opencode").toggle() end,
        { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "<leader>or", function() return require("opencode").operator("@this ") end,
        { desc = "Add range to opencode", expr = true })

      vim.keymap.set("n", "<C-A-u>", function() require("opencode").command("session.half.page.up") end,
        { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<C-A-d>", function() require("opencode").command("session.half.page.down") end,
        { desc = "Scroll opencode down" })
    end,
  },
  {
    "carlos-algms/agentic.nvim",

    opts = {
      -- Any ACP-compatible provider works. Built-in: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "copilot-acp" | "auggie-acp" | "mistral-vibe-acp" | "cline-acp" | "goose-acp" | "kiro-acp" | "pi-acp"
      provider = "kiro-acp", -- setting the name here is all you need to get started
    },

    -- these are just suggested keymaps; customize as desired
    keys = {
      {
        "<leader>at",
        function() require("agentic").toggle() end,
        mode = { "n" },
        desc = "Toggle Agentic Chat"
      },
      {
        "<leader>as",
        function() require("agentic").add_selection_or_file_to_context() end,
        mode = { "n", "v" },
        desc = "Add file or selection to Agentic to Context"
      },
      {
        "<leader>an",
        function() require("agentic").new_session() end,
        mode = { "n" },
        desc = "New Agentic Session"
      },
      {
        "<leader>ar",
        function()
            require("agentic").restore_session()
        end,
        desc = "Agentic Restore session",
        silent = true,
        mode = { "n" },
      },
      {
        "<leader>ad", -- ai Diagnostics
        function()
            require("agentic").add_current_line_diagnostics()
        end,
        desc = "Add current line diagnostic to Agentic",
        mode = { "n" },
      },
      {
        "<leader>aD", -- ai all Diagnostics
        function()
            require("agentic").add_buffer_diagnostics()
        end,
        desc = "Add all buffer diagnostics to Agentic",
        mode = { "n" },
      },
    },
  },
  {
    "Cannon07/code-preview.nvim",
    config = function()
      require("code-preview").setup()
    end,
  }
}


return
{
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
  dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
  -- minimum number of file buffers that need to be open to save
  -- Set to 0 to always save
  need = 1,
  branch = true, -- use git branch to save session
  },

  init = function()
        vim.api.nvim_create_user_command("Persistence", function() require("persistence").select() end, {desc="Select a session to load"})
  end,
}

local M = {}

function M.init_local_ai_qwen3()
  local cmp_ai = require('cmp_ai.config')

  cmp_ai:setup({
    max_lines = 100,
    provider = 'Ollama',

    provider_options = {
      model = 'Qwen/Qwen3-8B-GGUF:Q8_0',
      base_url = "http://localhost:8080/completion",
      auto_unload = false, -- Set to true to automatically unload the model when exiting nvim.
      promt = function(lines_before, lines_after)
        return "<|fim_prefix|>" .. lines_before .. "<|fim_suffix|>" .. lines_after .. "<|fim_middle|>"
      end,
    },
    notify = true,
    notify_callback = function(msg)
      vim.notify(msg)
    end,
    run_on_every_keystroke = true,
    ignored_file_types = {},
  })
end

return M

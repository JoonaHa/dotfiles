return {
  {
    'quarto-dev/quarto-nvim',
    ft = { 'quarto' },
    opts = {},
    dependencies = {
      'quarto-dev/quarto-nvim',
      'jmbuhr/otter.nvim',
      'hrsh7th/nvim-cmp',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter'
    },

    config =function ()
      require('quarto').setup{
        debug = false,
        closePreviewOnExit = false,
        lspFeatures = {
          enabled = true,
          chunks = "curly",
          languages = { "r", "python", "julia", "bash", "html" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = 'slime', -- 'molten' or 'slime'
        },
      }
    end,

    init =function ()
      local runner = require("quarto.runner") vim.keymap.set("n", "<localleader>rc", runner.run_cell,  { desc = "run cell", silent = true })
      vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
      vim.keymap.set("n", "<localleader>rA", runner.run_all,   { desc = "run all cells", silent = true })
      vim.keymap.set("n", "<localleader>rl", runner.run_line,  { desc = "run line", silent = true })
      vim.keymap.set("v", "<localleader>r",  runner.run_range, { desc = "run visual range", silent = true })
      vim.keymap.set("n", "<localleader>RA", function()
        runner.run_all(true)
      end, { desc = "run all cells of all languages", silent = true })
    end
  },
  { -- send code from python/r/qmd documets to a terminal or REPL
    -- like ipython, R, bash
    'jpalardy/vim-slime',
    init = function()
      vim.b['quarto_is_python_chunk'] = false
      Quarto_is_in_python_chunk = function()
        require('otter.tools.functions').is_otter_language_context 'python'
      end


      vim.g.slime_target = 'neovim'
      vim.g.slime_no_mappings = true
      vim.g.slime_python_ipython = 1
      --- Send code to terminal with vim-slime
      --- If an R terminal has been opend, this is in r_mode
      --- and will handle python code via reticulate when sent
      --- from a python chunk.
      --- TODO: incorpoarate this into quarto-nvim plugin
      --- such that QuartoRun functions get the same capabilities
      --- TODO: figure out bracketed paste for reticulate python repl.
      local function send_cell()
        if vim.b['quarto_is_r_mode'] == nil then
          vim.fn['slime#send_cell']()
          return
        end
        if vim.b['quarto_is_r_mode'] == true then
          vim.g.slime_python_ipython = 0
          local is_python = require('otter.tools.functions').is_otter_language_context 'python'
          if is_python and not vim.b['reticulate_running'] then
            vim.fn['slime#send']('reticulate::repl_python()' .. '\r')
            vim.b['reticulate_running'] = true
          end
          if not is_python and vim.b['reticulate_running'] then
            vim.fn['slime#send']('exit' .. '\r')
            vim.b['reticulate_running'] = false
          end
          vim.fn['slime#send_cell']()
        end
      end

      --- Send code to terminal with vim-slime
      --- If an R terminal has been opend, this is in r_mode
      --- and will handle python code via reticulate when sent
      --- from a python chunk.
      local slime_send_region_cmd = ':<C-u>call slime#send_op(visualmode(), 1)<CR>'
      slime_send_region_cmd = vim.api.nvim_replace_termcodes(slime_send_region_cmd, true, false, true)
      local function send_region()
        -- if filetyps is not quarto, just send_region
        if vim.bo.filetype ~= 'quarto' or vim.b['quarto_is_r_mode'] == nil then
          vim.cmd('normal' .. slime_send_region_cmd)
          return
        end
        if vim.b['quarto_is_r_mode'] == true then
          vim.g.slime_python_ipython = 0
          local is_python = require('otter.tools.functions').is_otter_language_context 'python'
          if is_python and not vim.b['reticulate_running'] then
            vim.fn['slime#send']('reticulate::repl_python()' .. '\r')
            vim.b['reticulate_running'] = true
          end
          if not is_python and vim.b['reticulate_running'] then
            vim.fn['slime#send']('exit' .. '\r')
            vim.b['reticulate_running'] = false
          end
          vim.cmd('normal' .. slime_send_region_cmd)
        end
      end
    end,

    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = true

      local function mark_terminal()
        local job_id = vim.b.terminal_job_id
        vim.print('job_id: ' .. job_id)
      end

      local function set_terminal()
        vim.fn.call('slime#config', {})
      end
      vim.keymap.set('n', '<leader>cm', mark_terminal, { desc = '[m]ark terminal' })
      vim.keymap.set('n', '<leader>cs', set_terminal, { desc = '[s]et terminal' })
    end,
  },
}

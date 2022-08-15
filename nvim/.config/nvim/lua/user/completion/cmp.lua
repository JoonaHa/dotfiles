local cmp_instance = {}

function cmp_instance.init()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
  end

  vim.opt.completeopt = { "menu", "menuone", "noselect" }

  cmp.setup {
    enabled = function()
      if vim.bo.buftype == 'prompt' then
        return false
      end
      local context = require 'cmp.config.context'
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == 'c' then
        return true
      else
        return not context.in_treesitter_capture("comment")
          and not context.in_syntax_group("Comment")
      end
    end,
    preselect = cmp.PreselectMode.Item,
    formatting = {
      format = require('lspkind').cmp_format{
        mode = 'symbol_text', -- show only symbol annotations
        with_text = true,
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[api]",
          path = "[path]",
          luasnip = "[snip]",
          treesitter = "[TS]"
        }, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

        experimental = {
          native_menu = false,
          ghost_text = true,
        },
        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      }
    },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

    sources = {
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'luasnip' },
      { name = 'treesitter', },
      { name = 'buffer',},
      { name = 'nvim_lsp_document_symbol' },
      { name = 'latex_symbols' },
      { name = 'path' },

    },
    sorting = {
        -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,

        -- copied from cmp-under, but I don't think I need the plugin for this.
        -- I might add some more of my own.
        function(entry1, entry2)
          local _, entry1_under = entry1.completion_item.label:find "^_+"
          local _, entry2_under = entry2.completion_item.label:find "^_+"
          entry1_under = entry1_under or 0
          entry2_under = entry2_under or 0
          if entry1_under > entry2_under then
            return false
          elseif entry1_under < entry2_under then
            return true
          end
        end,

        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },

    duplicates = {
      nvim_lsp = 1,
      luasnip = 1,
      cmp_tabnine = 1,
      buffer = 1,
      path = 1,
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      },
    },
    mapping = {
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<Down>"] = cmp.mapping.select_next_item(),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable,
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<CR>"] = cmp.mapping.confirm { select = false },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    }
  }

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })


  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'spell' },
      { name = 'dictionary' },
      { name = 'buffer' },
    })
  })

  cmp.setup.filetype('markdown', {
    sources = cmp.config.sources({
      { name = 'spell' },
      { name = 'dictionary' },
      { name = 'buffer' },
    })
  })

  cmp.setup.filetype('text', {
    sources = cmp.config.sources({
      { name = 'spell' },
      { name = 'dictionary' },
      { name = 'buffer' },
    })
  })

  cmp.setup.filetype('tex', {
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'latex_symbols' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'luasnip' },
      { name = 'spell' },
      { name = 'dictionary' },
      { name = 'buffer' },
    })
  })



  return cmp_instance
end

function cmp_instance.get_capabilites()
  return function(capabilities) return require("cmp_nvim_lsp").update_capabilities(capabilities) end

end

return cmp_instance

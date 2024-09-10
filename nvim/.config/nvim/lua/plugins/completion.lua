return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "f3fora/cmp-spell",
      "ray-x/cmp-treesitter",
      "uga-rosa/cmp-dictionary",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lua", 
      "kdheepak/cmp-latex-symbols",
    -- Luasnip
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      require('luasnip.loaders.from_vscode').lazy_load()
      local luasnip = require("luasnip")



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
          { name = 'nvim_lsp_signature_help' },
          {
            name = "nvim_lsp",
            entry_filter = function(entry, ctx)
              local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
              if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                return false
              end
              if kind == "Text" then
                return false
              end
              return true
            end,
          },
          { name = 'nvim_lua' },
          { name = 'latex_symbols' },
          { name = 'luasnip' },
          { name = 'treesitter' },
          { name = 'buffer' },
          { name = 'path' },

        },
        --sorting = {
        --    -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
        --  comparators = {
        --    cmp.config.compare.locality,
        --    cmp.config.compare.score,
        --    cmp.config.compare.kind,
        --    cmp.config.compare.order,

        --  },
        --},

        duplicates = {
          nvim_lsp = 1,
          luasnip = 1,
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
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ['<C-h>'] = cmp.mapping.scroll_docs(-4),
          ['<C-l>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
        })
      }

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'nvim_lsp_document_symbol' },
         -- { name = 'buffer' }
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        --mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'spell' },
          { name = 'dictionary' },
          { name = 'path' },
        })
      })

      cmp.setup.filetype('markdown', {
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'treesitter' },
          { name = 'spell' },
          { name = 'dictionary' },
          { name = 'buffer' },
          { name = 'path' },
        })
      })

      cmp.setup.filetype('tex', {
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'latex_symbols' },
          { name = 'luasnip' },
          { name = 'spell' },
          { name = 'dictionary' },
          { name = 'treesitter' },
          { name = 'buffer' },
        })
      })

    end,
  },
}

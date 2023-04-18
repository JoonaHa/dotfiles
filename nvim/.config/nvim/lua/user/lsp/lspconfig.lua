-- LSP settings.
local lsp_instance = {}

local on_attach = function(client, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	nmap("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
	nmap("]d", vim.diagnostic.goto_next, "Next diagnostic")
	nmap("<leader>df", vim.diagnostic.open_float, "[D]iagnostic [F]loat")
	nmap("<leader>dl", vim.diagnostic.setloclist, "[D]iagnostic [L]ist")

	if client.server_capabilities.document_highlight then
		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		vim.api.nvim_create_autocmd("CursorHold", {
			group = "lsp_document_highlight",
			pattern = "<buffer>",
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = "lsp_document_highlight",
			pattern = "<buffer>",
			callback = vim.lsp.buf.clear_references,
		})
	end
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Use LSP as the handler for formatexpr and tagfunc.
	if client.server_capabilities.goto_definition == true then
		vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
	end

	if client.server_capabilities.document_formatting == true then
		vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	end
	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "Format current buffer with LSP" })

	require("user.ui-plugins").lsp_attach(client, bufnr)
	require("user.lsp.inlay-hints").lsp_attach(client, bufnr)
end

local function custom_lsp_setups(capabilities, on_attach)
	return {
		-- The first entry (without a key) will be the default handler
		-- and will be called for each installed server that doesn't have
		-- a dedicated handler.
		function(server_name) -- default handler (optional)
			-- Define `root_dir` when needed
			-- See: https://github.com/neovim/nvim-lspconfig/issues/320
			-- This is a workaround, maybe not work with some servers.
			-- local root_dir = function()
			-- 	return vim.fn.getcwd()
			-- end
			require("lspconfig")[server_name].setup({
				on_attach = on_attach,
			--	root_dir = root_dir,
				capabilities = capabilities,
			})
		end,
		-- Next, you can provide targeted overrides for specific servers.
		["rust_analyzer"] = function()
			require("lspconfig").rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						diagnostics = {
							enable = true,
						},
					},
				},
			})
		end,
		["lua_ls"] = function()
			-- Example custom configuration for lua
			-- Make runtime files discoverable to the server
			local runtime_path = vim.split(package.path, ";")
			table.insert(runtime_path, "lua/?.lua")
			table.insert(runtime_path, "lua/?/init.lua")
			require("lspconfig").lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT)
							version = "LuaJIT",
							-- Setup your lua path
							path = runtime_path,
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = { enable = false },
					},
				},
			})
		end,
		["omnisharp"] = function()
			require("lspconfig").omnisharp.setup({
				on_attach = on_attach,
				cmd = { "dotnet", "/home/joona/.local/share/nvim/mason/packages/omnisharp/OmniSharp.dll" },
				enable_import_completion = true,
				enable_roslyn_analyzers = true,
			})
		end
	}
end

function lsp_instance.init(servers, capabilities_reg_func)
	vim.diagnostic.config({
		update_in_insert = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})
	-- Add additional capabilities supported by user.completion objecet
	-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
	local capabilities = capabilities_reg_func()
	-- TODO: Check if coq returns valid functionalities
	capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.preselectSupport = true
	capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
	capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
	capabilities.textDocument.completion.completionItem.deprecatedSupport = true
	capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
	capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = { "documentation", "detail", "additionalTextEdits" },
	}

	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = servers,
	})

	-- Let Mason call the default handlers. See :h mason-lspconfig-automatic-server-setup
	require("mason-lspconfig").setup_handlers(custom_lsp_setups(capabilities, on_attach))
end

return lsp_instance

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local on_attach = require('lsp-keybind').on_attach

require'lspconfig'.sumneko_lua.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	file = {"lua"},
	single_file_support = true,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim', 'root_pattern'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

require'lspconfig'.pyright.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = {"python"},
	settings ={
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true
			}
		},
	},
	single_file_support = true
}

require'lspconfig'.jdtls.setup {
	filetypes = {"java"},
	single_file_support = true,
}

require'lspconfig'.tsserver.setup({
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	init_options = {hostInfo = "neovim"},
})

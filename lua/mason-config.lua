require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {'tsserver', 'eslint', 'html'},
})
require('neodev').setup()
require('fidget').setup()

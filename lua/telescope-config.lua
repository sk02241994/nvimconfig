require('telescope').setup{
	defaults = {
		mappings = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
			},
		},
	},
    pickers = {
        find_files = {hidden = true}
    },
}

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', "T", ":Telescope<cr>", {desc = "Open telescope"})
vim.keymap.set('n', "<leader>ff", telescope_builtin.find_files, {desc = "Find files"})
vim.keymap.set('n', "<leader>sh", telescope_builtin.help_tags, {desc = "Help"})
vim.keymap.set('n', "<leader>fw", telescope_builtin.grep_string, {desc = "Find word"})
vim.keymap.set('n', "<leader>fg", telescope_builtin.live_grep, {desc = "Live grep"})
vim.keymap.set('n', "<leader>sd", telescope_builtin.diagnostics, {desc = "Show diagnostics"})
vim.keymap.set('n', "<leader>?", telescope_builtin.oldfiles, {desc = "Find recently opened"})
vim.keymap.set('n', "<leader><space>", telescope_builtin.buffers, {desc = "Find existing buffers"})
vim.keymap.set('n', "<leader>/", function()
	telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown{
		winblend = 10,
		previewer = false,
	})
end, {desc = "Fuzzily search in current buffers"})

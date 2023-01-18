vim.b.autoindent = true
vim.b.smartindent = true
vim.b.tabstop = 4
vim.opt.tabstop = 4
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.wo.number = true
vim.wo.relativenumber = true

vim.keymap.set('n', '<C-t>' , ':tabnew<CR>', {silent = true})
vim.keymap.set('n', '<C-w>' , ':close<CR>', {silent = true})

vim.keymap.set('n', '<C-l>' , '<C-w>l', {silent = true})
vim.keymap.set('n', '<C-k>' , '<C-w>k', {silent = true})
vim.keymap.set('n', '<C-j>' , '<C-w>j', {silent = true})
vim.keymap.set('n', '<C-h>' , '<C-w>h', {silent = true})

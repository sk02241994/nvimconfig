vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.ruler = true
vim.opt.colorcolumn = "80"
vim.opt.updatetime = 250
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.keymap.set('n', '<C-t>' , ':tabnew<CR>', {silent = true})
vim.keymap.set('n', '<C-w>' , ':close<CR>', {silent = true})
vim.keymap.set('n', '<tab>' , ':tabNext<CR>', {silent = true})
vim.keymap.set('n', '<S-tab>' , ':tabprevious<CR>', {silent = true})

vim.keymap.set('n', '<C-l>' , '<C-w>l', {silent = true})
vim.keymap.set('n', '<C-k>' , '<C-w>k', {silent = true})
vim.keymap.set('n', '<C-j>' , '<C-w>j', {silent = true})
vim.keymap.set('n', '<C-h>' , '<C-w>h', {silent = true})

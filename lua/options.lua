require("nvchad.options")

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
local opt = vim.opt

opt.colorcolumn = "120"
opt.cursorline = true
opt.cursorcolumn = true
opt.listchars = "space:.,eol:$,tab:>>"
opt.list = true
vim.cmd([[set grepprg=rg\ --vimgrep]])

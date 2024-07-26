vim.cmd[[
highlight NORMAL guibg=NONE ctermbg=NONE
]]
---@type ChadrcConfig 
 local M = {}
 M.ui = {theme = 'gruvbox'}
 M.plugins = "custom.plugins"
 M.mappings = require "custom.mappings"
 return M

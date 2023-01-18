local config_path = vim.fn.getcwd() .. '/.vimconf/config.lua'
local file = io.open(config_path)
if file ~= nil then
    vim.cmd(":luafile " .. config_path)
end

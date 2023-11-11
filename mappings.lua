local M = {}

vim.cmd[[set grepprg=rg\ --vimgrep]]
M.general = {
  n = {
    ['<leader>fg'] = {'<cmd>grep -S "\\b<cword>\\b"<cr>', "Grep word under cursor"},
    ['<F4>'] = {'<cmd>cn<cr>', "Quick fix next"},
    ['<F5>'] = {'<cmd>cp<cr>', "Quick fix previous"},
    ['<F2>'] = {
      function ()
        local qf_exists = false
        for _, win in pairs(vim.fn.getwininfo()) do
          if win['quickfix'] == 1 then
            qf_exists = true
          end
        end
        if qf_exists then
          vim.cmd[[cclose]]
        else
          vim.cmd[[copen]]
        end
      end, "Quick fix toggle"},
  }
}

return M
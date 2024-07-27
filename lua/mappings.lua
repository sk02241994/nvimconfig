require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map('n', '<a-up>', '<c-w>+', {desc = 'resize height increase'})
map('n', '<a-down>', '<c-w>-', {desc = 'resize height decrease'})
map('n', '<a-left>', '<c-w>>', {desc = 'resize width increase'})
map('n', '<a-right>', '<c-w><', {desc = 'resiez width decrease'})
map('n', '<F4>', '<cmd>cn<cr>', {desc = 'Quickfix next'})
map('n', '<F5>', '<cmd>cp<cr>', {desc = 'Quickfix prev'})
map('n', '<F2>', function()
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
end, {desc = "Toggle quickfix"})
map('n', '<leader>fg', '<cmd>grep -s -w "<cword>"<cr>', {desc = "Find word under cursor"})

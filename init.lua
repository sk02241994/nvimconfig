local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
  { 'skywind3000/asyncrun.vim' },
  { 'williamboman/mason.nvim', config = true },
})

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = ' '
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
-- vim.opt.colorcolumn="120"
-- vim.opt.cursorcolumn=true
-- vim.opt.cursorline=true
vim.opt.swapfile = false
vim.o.hlsearch = true
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.showtabline = 2
vim.wo.signcolumn = 'yes'
vim.o.termguicolors = true
vim.opt.listchars = 'space:.,eol:$,tab:>>'
vim.opt.list = true
vim.o.completeopt = 'menuone,noselect'
vim.keymap.set('n', '<C-l>', '<C-w>l', {noremap = true})
vim.keymap.set('n', '<C-k>', '<C-w>k', {noremap = true})
vim.keymap.set('n', '<C-j>', '<C-w>j', {noremap = true})
vim.keymap.set('n', '<C-h>', '<C-w>h', {noremap = true})
vim.keymap.set('n', '<Up>', '<NOP>', {noremap = true})
vim.keymap.set('n', '<Down>', '<NOP>', {noremap = true})
vim.keymap.set('n', '<Left>', '<NOP>', {noremap = true})
vim.keymap.set('n', '<Right>', '<NOP>', {noremap = true})
vim.keymap.set({'n', 'i'}, '<C-s>', '<cmd>write<cr>', {noremap = true, desc = 'save'})
vim.keymap.set('n', '<leader><C-n>', "<cmd>tabnew<cr>", { desc = 'new tab' })
vim.keymap.set('n', '<tab>', "<cmd>bn<CR>", { desc = 'next buffer' })
vim.keymap.set('n', '<S-tab>', '<cmd>bp<CR>', { desc = 'previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', {desc = 'Buffer delete'})
vim.keymap.set('n', '<leader>fb', ':buffers<CR>:buffer ', {desc = 'Find buffers'})
vim.keymap.set('n', '<leader>fm', ':marks<CR>:normal \'', {desc = 'Find marks'})
vim.keymap.set('n', '<a-up>', '<c-w>+', {desc = 'resize height increase'})
vim.keymap.set('n', '<a-down>', '<c-w>-', {desc = 'resize height decrease'})
vim.keymap.set('n', '<a-left>', '<c-w>>', {desc = 'resize width increase'})
vim.keymap.set('n', '<a-right>', '<c-w><', {desc = 'resiez width decrease'})
-- vim.keymap.set('n', '<leader>fb', ':buffers<cr>:buffer<space>', { desc = 'Show buffers' })
vim.keymap.set('n', "<leader>fg", "<cmd>grep -sw \"<cword>\"<cr>:cwindow<cr>", {desc = "Find word under cursor"})
-- vim.keymap.set('n', '<leader>m', ':marks<cr>:\'', { desc = 'Show marks' })
-- vim.keymap.set('n', '<leader>v', ':registers<cr>', { desc = 'Show marks' })
vim.keymap.set('n', '<F4>', "<cmd>cn<cr>", { desc = 'Quickfix next' })
vim.keymap.set('n', '<F5>', "<cmd>cp<cr>", { desc = 'Quickfix previous' })
vim.keymap.set('n', '<F2>', function()
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

vim.o.background = "dark"
vim.opt.termguicolors = true

vim.cmd[[
set grepprg=rg\ --vimgrep
highlight NORMAL guibg=NONE ctermbg=NONE
syntax off
]]

function get_mode()
  local mode_map = {
    n = 'Normal',
    i = 'Insert',
    v = 'Visual',
    [''] = 'V-Line',
    V = 'V-Line',
    c = 'Command',
    no = 'Operator Pending',
    s = 'Select',
    S = 'S-Line',
    R = 'Replace',
    Rv = 'V-Replace',
    t = 'Terminal'
  }
  local current_mode = vim.api.nvim_get_mode().mode
  return mode_map[current_mode] or current_mode
end

function get_git_branch()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  if branch ~= "" then
    return '[' .. string.gsub(branch, "%s+", "") .. ']'
  else
    return ""
  end
end

function lsp_status()
  local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf()})
  local messages = {}
  for _, client in ipairs(clients) do
    table.insert(messages, string.format('%s', client.name))
    table.insert(messages, string.format('%s', vim.lsp.status()))
  end
  return table.concat(messages, ' ')
end

function lsp_diagnostic_count()
  local counts = {
    error = 0,
    warn = 0,
    info = 0,
    hint = 0,
  }
  for _, diagnostic in ipairs(vim.diagnostic.get(vim.api.nvim_get_current_buf(), {
    severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN, vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT }
  })) do
    local severity = string.lower(vim.diagnostic.severity[diagnostic.severity])
    counts[severity] = counts[severity] + 1
  end
  return string.format('E:%d W:%d I:%d H:%d', counts.error, counts.warn, counts.info, counts.hint)
end

vim.opt.statusline = "%{%v:lua.get_mode()%} %{%v:lua.get_git_branch()%} %F %{%v:lua.lsp_diagnostic_count()%}%< %=%{%v:lua.lsp_status()%}[bufno: %n]:%y[%l:%c of %L %p%%]"

local config_file = vim.fn.getcwd() .. '/.nvimconf.lua'
local file = io.open(config_file, 'r')
if file then
  vim.cmd('luafile ' .. config_file)
  file:close()
end

-- vim.opt.runtimepath:append("~/.config/nvim/custom_files/*")
-- vim.cmd('luafile ' .. '~/.config/nvim/custom_files/custom_config.lua')

--[[
This is plugin section
]]

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client ~= nil and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
    end
  end,
})

vim.diagnostic.config({virtual_text = true})

local mason_path = vim.fn.stdpath('data') .. '/mason/packages/'

vim.lsp.config('luals', {
  cmd = {mason_path .. 'lua-language-server/lua-language-server'},
  filetypes = {'lua'},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})
vim.lsp.enable('luals')

vim.lsp.config('clangd', {
  cmd = {'clangd'},
  single_file_support = true,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
})
vim.lsp.enable('clangd')

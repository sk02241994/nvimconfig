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
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', "nvim-telescope/telescope-live-grep-args.nvim" }
  },
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
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {},
  config = function()
    require("ibl").setup {scope = {enabled = true}}
  end },
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

vim.opt.statusline = "%{%v:lua.get_mode()%} %{%v:lua.get_git_branch()%} %F%< %=[bufno: %n]:%y[%l:%c of %L %p%%]"

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
require('telescope').setup {
  defaults = {
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    prompt_prefix = "   ",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  },
}

vim.keymap.set('n', '<leader>ds', '<cmd>Telescope treesitter<cr>', {desc = 'Telescope treesitter navigation'})
vim.keymap.set('n', '<leader>t', "<cmd>Telescope<cr>", { desc = 'Open telescope' })
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find file' })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Show buffers' })
vim.keymap.set('n', '<leader>fw', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fW', function() require('telescope').extensions.live_grep_args.live_grep_args() end, { desc = 'Live grep with args' })
vim.keymap.set('n', '<leader>fz', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find({fuzzy = false})
end, { desc = 'Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>m', '<cmd>Telescope marks<cr>', {desc = 'Open marks telescope'})
vim.keymap.set('n', '<leader>r', '<cmd>Telescope registers<cr>', {desc = 'Open marks telescope'})

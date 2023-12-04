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

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = ' '
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.opt.colorcolumn="120"
vim.opt.cursorcolumn=true
vim.opt.cursorline=true
vim.opt.swapfile = false

require("lazy").setup({
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', "nvim-telescope/telescope-live-grep-args.nvim" }
  },
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {'nvim-treesitter/nvim-treesitter-textobjects'},
  { 
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("nvim-tree").setup({})
    end,
  },
  { 'Mofiqul/vscode.nvim', priority = 1000 },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {'kdheepak/lazygit.nvim'},
  {'Mr-LLLLL/interestingwords.nvim'},
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
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {},
  config = function()
    require("ibl").setup {scope = {enabled = true}}
  end },
  {'preservim/tagbar'}

})

vim.o.hlsearch = true
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.wrap = false
vim.wo.relativenumber = true
vim.opt.listchars = 'space:.,eol:$,tab:>>'
vim.opt.list = true
vim.o.completeopt = 'menuone,noselect'
vim.keymap.set('n', '<C-l>', '<C-w>l', {noremap = true})
vim.keymap.set('n', '<C-k>', '<C-w>k', {noremap = true})
vim.keymap.set('n', '<C-j>', '<C-w>j', {noremap = true})
vim.keymap.set('n', '<C-h>', '<C-w>h', {noremap = true})
vim.keymap.set('n', '<leader><C-n>', "<cmd>tabnew<cr>", { desc = 'new tab' })
vim.keymap.set('n', '<tab>', function() vim.cmd.tabnext() end, { desc = 'next tab' })
vim.keymap.set('n', '<S-tab>', function() vim.cmd.tabprevious() end, { desc = 'previous tab' })

require('telescope').setup {
  defaults = {
    layout_config = {
      preview_width=0.5,
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

vim.keymap.set('n', '<leader>t', "<cmd>Telescope<cr>", { desc = 'Open telescope' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find file' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Show buffers' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fW', function() require('telescope').extensions.live_grep_args.live_grep_args() end, { desc = 'Live grep with args' })
vim.keymap.set('n', "<leader>fg", "<cmd>grep -S \"\\b<cword>\\b\"<cr>", {desc = "Find word under cursor"})
vim.keymap.set('n', '<leader>fz', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find({fuzzy = false})
end, { desc = 'Fuzzily search in current buffer]' })
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
vim.keymap.set('n', '<F8>', ':TagbarToggle<CR>', {desc = "Tagbar toggle"})

-- You don't need to set any of these options.
-- IMPORTANT!: this is only a showcase of how you can set default options!
require("telescope").setup {
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
    },
  },
}
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
vim.api.nvim_set_keymap("n", "<space>E", "<cmd>NvimTreeToggle<cr>", { noremap = true })

vim.o.background = "dark"
require('vscode').load()

require('lualine').setup({})

require'nvim-treesitter.configs'.setup {
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require("interestingwords").setup {
  colors = { '#aeee00', '#ff0000', '#0000ff', '#b88823', '#ffa724', '#ff2c4b' },
  search_count = true,
  navigation = true,
  search_key = "<leader>m",
  cancel_search_key = "<leader>M",
  color_key = "<leader>k",
  cancel_color_key = "<leader>K",
}
vim.cmd[[set grepprg=rg\ --vimgrep]]

-- Make shift plugin manager without installing plugins.
local paths
if vim.fn.has("win64") then
  paths = os.getenv('UserProfile') .. '/AppData/Local/nvim'
else
  paths = os.getenv('HOME') .. '/.config/nvim'
end

local plugins_path = paths .. '/.plugins'
local plugins = {}
if vim.fn.has('win64') then
  for dir in io.popen("dir \"" .. plugins_path .."\" /b"):lines() do table.insert(plugins, dir) end
else
  for dir in io.popen('ls -a "' .. plugins_path .. '"'):lines() do table.insert(plugins, dir) end
end

for _, k in pairs(plugins) do
  vim.opt.runtimepath:append(plugins_path .. '/' .. k)
end

-- override config
local override_path = paths .. '/config.lua'
local file = io.open(override_path)
if file ~= nil then
  file:close()
  vim.cmd(':luafile ' .. override_path)
end

local config_path = vim.fn.getcwd() .. '/.config/config.lua'
local config_file = io.open(config_path)
if config_file ~= nil then
  config_file:close()
  vim.cmd(':luafile ' .. config_file)
end

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
vim.keymap.set('n', '<leader>bd', ':buffers<CR>:bd! ', { desc = 'Buffer delete' })
vim.keymap.set('n', '<leader>fb', ':buffers<CR>:buffer<space>', {desc = 'Find buffers'})
vim.keymap.set('n', '<leader>fm', ':marks<CR>:normal \'', {desc = 'Find marks'})
vim.keymap.set('n', '<a-up>', '<c-w>+', {desc = 'resize height increase'})
vim.keymap.set('n', '<a-down>', '<c-w>-', {desc = 'resize height decrease'})
vim.keymap.set('n', '<a-left>', '<c-w>>', {desc = 'resize width increase'})
vim.keymap.set('n', '<a-right>', '<c-w><', {desc = 'resiez width decrease'})
vim.keymap.set('n', "<leader>fg", "<cmd>grep -sw --vimgrep \"<cword>\"<cr>:cwindow<cr>", {desc = "Find word under cursor"})
vim.keymap.set('n', "<leader>fw", ":grep ", {desc = "Grep it"})
vim.keymap.set('n', '<leader>v', ':registers<cr>:normal "p<left>', { desc = 'Show registers to paste' })
vim.keymap.set('n', '<leader>ch', ':chistory<CR>:chistory ', { desc = 'Show quickfix history' })
vim.keymap.set('n', '<F4>', "<cmd>cn<cr>", { desc = 'Quickfix next' })
vim.keymap.set('n', '<F5>', "<cmd>cp<cr>", { desc = 'Quickfix previous' })
vim.keymap.set('n', '<leader>e', ":Lex<cr>", { desc = 'Open explorer' })
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
vim.keymap.set('n', '<leader>s', ":tabnew | r !", {desc = "open running task and showing output in new tab"})

vim.o.background = "dark"
vim.opt.termguicolors = true

vim.cmd[[
set grepprg=rg
highlight NORMAL guibg=NONE ctermbg=NONE
syntax off
let g:netrw_winsize=20
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

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMonoNL Nerd Font:h10"
end
-- vim.opt.runtimepath:append("~/.config/nvim/custom_files/*")
-- vim.cmd('luafile ' .. '~/.config/nvim/custom_files/custom_config.lua')

local function fzf_file_finder()

  local tempfile = os.getenv("TEMP") .. "/fzf_select_file"
  vim.fn.delete(tempfile)

  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  local cmd = string.format('fzf --preview="cat {}" --preview-window=right:50%% > %s', tempfile)
  local term_job_id = vim.fn.termopen(cmd, {
    on_exit = function(_, exit_code, _)
      vim.schedule(function()
        vim.api.nvim_win_close(win, true)
        vim.api.nvim_buf_delete(buf, {force = true})
        local file = vim.fn.readfile(tempfile)[1]
        if file and file ~= '' then
          vim.cmd('edit ' .. vim.fn.fnameescape(file))
        end
      end)
    end,
  })
  vim.cmd('startinsert')
end
vim.api.nvim_create_user_command("FzfFiles", fzf_file_finder, {})
vim.keymap.set('n', '<leader>ff', "<cmd>FzfFiles<CR>", { desc = 'Fuzzy find' })

local function ranger_file_find()

  local tempfile = os.getenv("TEMP") .. "/ranger_file_find"
  vim.fn.delete(tempfile)

  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  local cmd = string.format('ranger --choosefiles="%s"', tempfile)
  local term_job_id = vim.fn.termopen(cmd, {
    on_exit = function(_, exit_code, _)
      vim.schedule(function()
        vim.api.nvim_win_close(win, true)
        vim.api.nvim_buf_delete(buf, {force = true})
        if vim.fn.filereadable(tempfile) == 0 then
          return
        end
        local file = vim.fn.readfile(tempfile)[1]
        if file and file ~= '' then
          vim.cmd('edit ' .. vim.fn.fnameescape(file))
        end
      end)
    end,
  })
  vim.cmd('startinsert')
end
vim.api.nvim_create_user_command("RangerFile", ranger_file_find, {})
vim.keymap.set('n', '<leader>r', "<cmd>RangerFile<CR>", { desc = 'Ranger file' })

--[[
This is plugin section
]]

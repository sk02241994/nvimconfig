vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = ' '
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2
vim.opt.colorcolumn="120"
vim.opt.cursorcolumn=true
vim.opt.cursorline=true
vim.opt.swapfile=false

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
vim.opt.listchars = 'space:.,eol:$,tab:>~'
vim.opt.list = true
vim.o.completeopt = 'menuone,noselect'
vim.keymap.set('n', '<C-l>', '<C-w>l', {noremap = true})
vim.keymap.set('n', '<C-k>', '<C-w>k', {noremap = true})
vim.keymap.set('n', '<C-j>', '<C-w>j', {noremap = true})
vim.keymap.set('n', '<C-h>', '<C-w>h', {noremap = true})
vim.keymap.set('n', '<C-n>', "<cmd>tabnew<cr>", { desc = 'new tab' })
vim.keymap.set('n', '<tab>', function() vim.cmd.tabnext() end, { desc = 'next tab' })
vim.keymap.set('n', '<S-tab>', function() vim.cmd.tabprevious() end, { desc = 'previous tab' })
vim.keymap.set('n', '<leader>E', "<cmd>Lexplore<cr>", {desc = 'Explore'})
vim.keymap.set('n', '<leader>fb', ":buffers<CR>:buffer<Space>", {desc = 'Show buffers'})
vim.cmd[[set grepprg=rg\ --vimgrep]]
vim.keymap.set('n', "<leader>fw", ":grep<Space>", {desc = "Find word"})
vim.keymap.set('n', "<leader>ff", ":e<Space>", {desc = "Find file"})
vim.keymap.set('n', "<leader>fg", "<cmd>grep -S \"\\b<cword>\\b\"<cr>", {desc = "Find word under cursor"})

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
-- vim.cmd.colorscheme "gruvbox"

-- status line
local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
      mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
      mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
      mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "R" then
      mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
      mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
      mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end

local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
      return " "
  end

  return string.format(" %%<%s/", fpath)
end

local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then
      return ""
  end
  return fname .. " "
end

local function filetype()
  return string.format(" %s ", vim.bo.filetype):upper()
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %l:%c "
end

local function lsp_progress ()
  local lsp = vim.lsp.util.get_progress_messages()[1]
  if lsp then
    local name = lsp.name or ""
    local msg = lsp.message or ""
    local percentage = lsp.percentage or 0
    local title = lsp.title or ""
    return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
  end

  return ""
end

Statusline = {}

Statusline.active = function()
  return table.concat {
    "%#Statusline#",
    update_mode_colors(),
    mode(),
    "%#Normal# ",
    filepath(),
    filename(),
    lsp_progress(),
    "%#Normal#",
    "%=%#StatusLineExtra#",
    filetype(),
    lineinfo(),
  }
end

function Statusline.inactive()
  return " %F"
end

function Statusline.short()
  return "%#StatusLineNC#   NvimTree"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)

-- Lsp setup

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.cmd([[autocmd User LspProgressUpdate redrawstatus]])
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {desc = '[R]e[n]ame', buffer = args.buf})
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction', buffer = args.buf})

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {desc = '[G]oto [D]efinition', buffer = args.buf})
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, {desc = '[G]oto [R]eferences', buffer = args.buf})
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, {desc = '[G]oto [I]mplementation', buffer = args.buf})
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, {desc = 'Type [D]efinition', buffer = args.buf})
    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, {desc = '[D]ocument [S]ymbols', buffer = args.buf})
    vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, {desc = '[W]orkspace [S]ymbols', buffer = args.buf})

    -- See `:help K, ` for why this keymap
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {desc = 'Hover Documentation', buffer = args.buf})
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {desc = 'Signature Documentation', buffer = args.buf})

    -- Lesser used 'n', LSP functionality
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {desc = '[G]oto [D]eclaration', buffer = args.buf})
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {desc = '[W]orkspace [A]dd Folder', buffer = args.buf})
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, {desc = '[W]orkspace [R]emove Folder', buffer = args.buf})
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, {desc = '[W]orkspace [L]ist Folders', buffer = args.buf})
  end
})

local autocmd = vim.api.nvim_create_autocmd
autocmd("FileType", {
  pattern = "lua",
  callback = function()
    local client = vim.lsp.start({
      name = 'lua_ls',
      cmd = {vim.fn.stdpath('data') .. '/lua/bin/lua-language-server' },
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
              [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      }
    })
    vim.lsp.buf_attach_client(0, client)
  end
})

autocmd('FileType', {
  pattern = {'c', 'cpp'},
  callback = function ()
    local client = vim.lsp.start({
      name = "clangd",
      cmd = {'clangd'},
    })
    vim.lsp.buf_attach_client(0, client)
  end
})

autocmd('FileType', {
  pattern = {"py", "python"},
  callback = function()
    local client = vim.lsp.start({
      name = "pyright",
      cmd = {vim.fn.stdpath('data') .. '/pyright/bin/pyright-langserver', '--stdio'},
    })

    vim.lsp.buf_attach_client(0, client)
  end
})

autocmd('FileType', {
  pattern = {"cmake", "CMakeLists.txt"},
  callback = function()
    local client = vim.lsp.start({
      name = "cmake",
      cmd = {vim.fn.stdpath('data') .. '/pyright/bin/cmake-language-server'},
    })

    vim.lsp.buf_attach_client(0, client)
  end
})

autocmd('FileType', {
  pattern = {"kotlin"},
  callback = function()
    local client = vim.lsp.start({
      name = "cmake",
      cmd = {vim.fn.stdpath('data') .. '/kotlin-language-server/bin/kotlin-language-server'},
      root_dir = vim.fs.dirname(vim.fs.find({'settings.gradle'}, {upward = true})[1]) or vim.fn.getcwd()
    })

    vim.lsp.buf_attach_client(0, client)
  end
})

--[[
command for jdtls
java ^
  -Declipse.application=org.eclipse.jdt.ls.core.id1 ^
  -Dosgi.bundles.defaultStartLevel=4 ^
  -Declipse.product=org.eclipse.jdt.ls.core.product ^
  -Dlog.protocol=true ^
  -Dosgi.checkConfiguration=true ^
  -Dlog.level=ALL ^
  -Xms1g ^
  -Xmx4G ^
  --add-modules=ALL-SYSTEM ^
  --add-opens java.base/java.util=ALL-UNNAMED ^
  --add-opens java.base/java.lang=ALL-UNNAMED ^
  -jar {complete path to}\jdtls\plugins\org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar ^
  -configuration {complete path to}\jdtls\config_linux/win\ ^
  -data %1 ^
  -javaagent:{complete path to}\jdtls\lombok.jar 
--]]--
autocmd('FileType', {
  pattern = "java",
  callback = function()
    local root_markers = {'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle', 'classes', 'lib'}
    local root_dir = vim.fs.dirname(vim.fs.find(root_markers)[1])
    local home = os.getenv('TEMP')
    local workspace_folder = home .. "/.workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
    local client = vim.lsp.start({
      name = "jdtls",
      cmd = {vim.fn.stdpath('data') .. '/jdtls/jdtls', workspace_folder},
      root_dir = vim.fs.dirname(vim.fs.find(root_markers)[1]) or vim.fn.getcwd(),
      settings = {
        java = {
          -- home = 'E:/java/jdk1.8.0_342',
          eclipse = {downloadSources = true},
          maven = {downloadSources = true},
          gradle = {downloadSources = true},
          configuration = {
            updateBuildConfiguration = 'interactive',
            --[[runtimes = {
            name = 'JavaSE-8',
            path = 'E:/java/jdk1.8.0_342',
            defaults = true
            },
            {
            name = 'JavaSE-18',
            path = 'E:/java/java18',
            },
            {
            name = 'JavaSE-11',
            path = 'E:/java/java11'
            }]]--
          },
          implementationsCodeLens = {enabled = true},
          referencesCodeLens = {enabled = true},
          references = {includeDecompiledSources = true},
          maxConcurrentBuilds = 3,
        },
        signatureHelp = {enabled = true},
        completion = {
          favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
          },
          importOrder = {
            "java",
            "javax",
            "com",
            "org"
          },
        },
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
          },
          useBlocks = true,
        },
      },
    })
    vim.lsp.buf_attach_client(0, client)
  end
})

autocmd('FileType', {
  pattern = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  callback = function()
    local client = vim.lsp.start({
      name = "typescript-language-server",
      cmd = {vim.fn.stdpath('data') .. '/tsserver/bin/typescript-language-server', '--stdio'},
      init_options = {hostInfo = "neovim"},
    })

    vim.lsp.buf_attach_client(0, client)
  end
})

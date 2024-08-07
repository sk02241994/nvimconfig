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
vim.opt.colorcolumn = "120"
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
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
  { "nvim-treesitter/nvim-treesitter",            build = ":TSUpdate" },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("nvim-tree").setup({})
    end,
  },
  { 'Mofiqul/vscode.nvim',           priority = 1000 },
  { 'kdheepak/lazygit.nvim' },
  { 'Mr-LLLLL/interestingwords.nvim' },
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
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      require("ibl").setup { scope = { enabled = true } }
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
  },
  { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
  { 'mfussenegger/nvim-jdtls' },
  { "ms-jpq/coq_nvim" },
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
vim.opt.listchars = 'space:.,eol:$,tab:>>'
vim.opt.list = true
vim.o.completeopt = 'menuone,noselect'
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-s>', '<cmd>write<cr>', { noremap = true, desc = 'save' })
vim.keymap.set('n', '<leader><C-n>', "<cmd>tabnew<cr>", { desc = 'new tab' })
vim.keymap.set('n', '<tab>', "<cmd>bn<CR>", { desc = 'next buffer' })
vim.keymap.set('n', '<S-tab>', '<cmd>bp<CR>', { desc = 'previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = 'Buffer delete' })
vim.keymap.set('n', '<a-up>', '<c-w>+', { desc = 'resize height increase' })
vim.keymap.set('n', '<a-down>', '<c-w>-', { desc = 'resize height decrease' })
vim.keymap.set('n', '<a-left>', '<c-w>>', { desc = 'resize width increase' })
vim.keymap.set('n', '<a-right>', '<c-w><', { desc = 'resiez width decrease' })

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

vim.keymap.set('n', '<leader>t', "<cmd>Telescope<cr>", { desc = 'Open telescope' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find file' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Show buffers' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fW', function() require('telescope').extensions.live_grep_args.live_grep_args() end,
  { desc = 'Live grep with args' })
vim.keymap.set('n', "<leader>fg", "<cmd>grep -s -w \"<cword>\"<cr>", { desc = "Find word under cursor" })
vim.keymap.set('n', '<leader>fz', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find({ fuzzy = false })
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
    vim.cmd [[cclose]]
  else
    vim.cmd [[copen]]
  end
end, { desc = "Toggle quickfix" })

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

vim.opt.termguicolors = true
require("bufferline").setup {}

require 'nvim-treesitter.configs'.setup {
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
vim.cmd [[set grepprg=rg\ --vimgrep]]

-- Lsp config
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame', buffer = args.buf })
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction', buffer = args.buf })

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition', buffer = args.buf })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = '[G]oto [R]eferences', buffer = args.buf })
    vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations,
      { desc = '[G]oto [I]mplementation', buffer = args.buf })
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition', buffer = args.buf })
    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, { desc = '[D]ocument [S]ymbols', buffer = args.buf })
    vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
      { desc = '[W]orkspace [S]ymbols', buffer = args.buf })

    -- See `:help K, ` for why this keymap
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation', buffer = args.buf })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation', buffer = args.buf })

    -- Lesser used 'n', LSP functionality
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration', buffer = args.buf })
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
      { desc = '[W]orkspace [A]dd Folder', buffer = args.buf })
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
      { desc = '[W]orkspace [R]emove Folder', buffer = args.buf })
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = '[W]orkspace [L]ist Folders', buffer = args.buf })
  end
})

--lspconfig
-- can look more into specific configs from this website https://www.andersevenrud.net/neovim.github.io/lsp/configurations/
local coq = require("coq")
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities({
  cmd = { 'lua-language-server' },
  capabilities = capabilities,
  settings = {
    Lua = {
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
}))

lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = { hostInfo = "neovim" },
  single_file_support = true,
  capabilities = capabilities,
}))

lspconfig.clangd.setup(coq.lsp_ensure_capabilities({
  cmd = { 'clangd' },
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  single_file_support = true,
}))

lspconfig.pyright.setup(coq.lsp_ensure_capabilities({
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true
      }
    }
  },
  single_file_support = true,
  capabilities = capabilities,
}))

lspconfig.cmake.setup(coq.lsp_ensure_capabilities({
  cmd = { 'cmake-language-server' },
  filetypes = { "cmake", "CMakeLists.txt" },
  init_options = { buildDirectory = "build" },
  single_file_support = true,
  capabilities = capabilities,
}))

local root_files = { 'settings.gradle' }
lspconfig.kotlin_language_server.setup(coq.lsp_ensure_capabilities({
  cmd = { 'kotlin-language-server' },
  capabilities = capabilities,
  filetypes = { "kotlin" },
  root_dir = function()
    return vim.fs.dirname(vim.fs.find(root_files, {})[1]) or vim.fn.getcwd()
  end,
  single_file_support = true,
  init_options = {
    completion = {
      snippets = { enabled = true },
    }
  },
}))

--[[
JDTLS_PATH="$LSP/jdtls"
JDT_FILE=$(find $JDTLS_PATH -name org.eclipse.equinox.launcher_*.jar)
LOMBOK=$(find $JDTLS_PATH -name lombok.jar)
CONFIG_LINUX=$(find $JDTLS_PATH -name config_linux)

java \
  -javaagent:$LOMBOK \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dosgi.checkConfiguration=true \
  -Dlog.level=ALL \
  -Xms1024m \
  -Xmx3000m \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED \
  -jar "$JDT_FILE" \
  -configuration "$CONFIG_LINUX" \
  -data $TEMP/$1
]] --
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local root_marker = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
lspconfig.jdtls.setup(coq.lsp_ensure_capabilities({
  cmd = { 'jdtls', '.workspace_' .. project_name },
  capabilities = capabilities,
  single_file_support = true,
  on_attach = function(_, bufnr)
    vim.keymap.set('n', '<leader>joi', "<cmd>lua require('jdtls').organize_imports()<CR>",
      { desc = 'Java Organize Imports', buffer = bufnr })
    vim.keymap.set('n', '<leader>jtc', "<cmd>lua require('jdtls').test_class()<CR>",
      { desc = 'Java test class', silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>jtnm', "<cmd>lua require('jdtls').test_nearest_method()<CR>",
      { desc = 'Java test nearest method', silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>jev', "<cmd>lua require('jdtls').extract_variable_all()<CR>",
      { desc = 'Java extract variable all', silent = true, buffer = bufnr })
    vim.keymap.set('v', '<leader>jem', "<ESC><CR>lua require('jdtls').extract_method(true)<CR>",
      { desc = 'Java extract method', buffer = bufnr })
    vim.keymap.set('n', '<leader>jec', "<CR>lua require('jdtls').extract_constant()<CR>",
      { desc = 'Java extract constant', buffer = bufnr })
  end,
  init_options = {
    bundles = {},
  },
  root_dir = function ()
    return require('jdtls.setup').find_root(root_marker)
  end,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        }
      },
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      referenceCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      inlayHints = {
        parameterNames = {
          enabled = 'all'
        }
      },
      extendedClientCapabilities = require('jdtls').extendedClientCapabilities,
      configuration = {
        updateBuildConfiguration = "interactive",
        --[[runtimes = {
          {
            name = 'JavaSE-1.8',
            path = 'D:/java/java8',
            default = true,
          },
          {
            name = 'JavaSE-21',
            path = 'D:/java/java21'
          },
          {
            name = 'JavaSE-22',
            path = 'D:/java/java22'
          },
        },]]--
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        }
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        }
      },
    },
  }
}))

lspconfig.rust_analyzer.setup(coq.lsp_ensure_capabilities({
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  single_file_support = true,
  capabilities = capabilities,
}))

--cmp
local cmp = require 'cmp'
cmp.setup {
  sources = {
    { name = 'nvim_lsp' },
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    }),
  }
}

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
  local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
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

vim.opt.statusline =
"%{%v:lua.get_mode()%} %{%v:lua.get_git_branch()%} %F %{%v:lua.lsp_diagnostic_count()%}%< %=%{%v:lua.lsp_status()%}[bufno: %n]:%y[%l:%c of %L %p%%]"

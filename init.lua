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
vim.keymap.set('n', '<a-up>', '<c-w>+', {desc = 'resize height increase'})
vim.keymap.set('n', '<a-down>', '<c-w>-', {desc = 'resize height decrease'})
vim.keymap.set('n', '<a-left>', '<c-w>>', {desc = 'resize width increase'})
vim.keymap.set('n', '<a-right>', '<c-w><', {desc = 'resiez width decrease'})
vim.keymap.set('n', '<leader><C-n>', "<cmd>tabnew<cr>", { desc = 'new tab' })
vim.keymap.set('n', '<tab>', "<cmd>bNext<CR>", { desc = 'next buffer' })
vim.keymap.set('n', '<S-tab>', '<cmd>bprevious<CR>', { desc = 'previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', {desc = 'Buffer delete'})
vim.keymap.set('n', '<leader>E', "<cmd>Lexplore<cr>", {desc = 'Explore'})
vim.keymap.set('n', '<leader>fb', ":buffers<CR>:buffer<Space>", {desc = 'Show buffers'})
vim.cmd[[set grepprg=rg\ --vimgrep]]
vim.keymap.set('n', "<leader>fw", ":grep<Space>", {desc = "Find word"})
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

-- Lsp setup

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

local lspconfig = {
  lua = {
    pattern = {'lua'},
    name = "lua_ls",
    cmd = {'lua-language-server'},
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
  },

  c = {
    pattern = {'c', 'cpp'},
    name = 'clangd',
    cmd = {'clangd'},
  },

  python = {
    pattern = {'py', 'python'},
    name = 'pyright',
    cmd = {'pyright-langserver', '--stdio'},
    settings ={
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true
        }
      }
    },
  },

  cmake = {
    pattern = {"cmake", "CMakeLists.txt"},
    name = 'cmake',
    cmd = {'cmake-language-server'},
  },

  kotlin = {
    pattern = {'kotlin'},
    cmd = {'kotlin-language-server'},
    root_dir = vim.fs.dirname(vim.fs.find({'settings.gradle'}, {upward = true})[1]) or vim.fn.getcwd()
  },

  java = {
    pattern = {'java'},
    callback = function()
      local root_markers = {'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle', 'classes', 'lib'}
      local root_dir = vim.fs.dirname(vim.fs.find(root_markers, {})[1])
      local workspace_folder = "/.workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
      local client = vim.lsp.start({
        name = "jdtls",
        cmd = {'jdtls', workspace_folder},
        root_dir = vim.fs.dirname(vim.fs.find(root_markers, {})[1]) or vim.fn.getcwd(),
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
  },

  javascript_typescript = {
    pattern = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    callback = function()
      local client = vim.lsp.start({
        name = "typescript-language-server",
        cmd = {'typescript-language-server', '--stdio'},
        init_options = {hostInfo = "neovim"},
      })
      vim.lsp.buf_attach_client(0, client)
    end
  }
}

for _, config in pairs(lspconfig) do
  autocmd("FileType", {
    pattern = config.pattern,
    callback = config.callback ~= nil and config.callback or function()
      local client = vim.lsp.start({
        name = config.name,
        cmd = config.cmd,
        settings = config.settings ~= nil and config.settings or {},
        root_dir = config.root_dir ~= nil and config.root_dir or vim.fn.getcwd(),
      })
      vim.lsp.buf_attach_client(0, client)
    end
  })
end

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
  local clients = vim.lsp.get_clients({bufnr = vim.api.nvim_get_current_buf()})
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

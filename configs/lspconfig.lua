local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

lspconfig.tsserver.setup {
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {hostInfo = "neovim"},
  single_file_support = true,
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.clangd.setup {
  cmd = {"clangd"},
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  single_file_support = true,
  on_attach = on_attach,
}

lspconfig.pyright.setup {
  filetypes = {"python"},
  settings ={
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
  on_attach = on_attach,
}

lspconfig.cmake.setup {
  filetypes = {"cmake", "CMakeLists.txt"},
  init_options = { buildDirectory = "build" },
  single_file_support = true,
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.kotlin_language_server.setup {
  cmd = { vim.fn.stdpath('data') .. '/mason/packages/kotlin-language-server/bin/kotlin-language-server' },
  capabilities = capabilities,
  filetypes = { "kotlin" },
  root_dir = lspconfig.util.root_pattern("settings.gradle"),
  on_attach = on_attach,
}

local root_marker = {'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle', 'classes', 'lib'}
local root_dir = vim.fs.dirname(vim.fs.find(root_marker)[1])
local home = os.getenv('TEMP')
local workspace_folder = home .. "/.workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
lspconfig.jdtls.setup {
  cmd = {vim.fn.stdpath('data') .. '/mason/packages/jdtls/bin/jdtls', workspace_folder},
  filetypes = {'java'},
  capabilities = capabilities,
  on_attach = on_attach,
  single_file_support = true,
  root_dir = function()
    return vim.fs.dirname(vim.fs.find(root_marker)[1])
  end,
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
}


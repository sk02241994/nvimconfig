-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local servers = { "html", "cssls" }
local coq = require("coq")

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }))
end

-- typescript
lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = { hostInfo = "neovim" },
  single_file_support = true,
  on_attach = on_attach,
  capabilities = capabilities,
}))

-- clangd
lspconfig.clangd.setup(coq.lsp_ensure_capabilities({
  cmd = { "clangd" },
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  single_file_support = true,
}))

-- pyright
lspconfig.pyright.setup(coq.lsp_ensure_capabilities({
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
      },
    },
  },
  single_file_support = true,
  capabilities = capabilities,
  on_attach = on_attach,
}))

-- cmake
lspconfig.cmake.setup(coq.lsp_ensure_capabilities({
  cmd = { "cmake-language-server" },
  filetypes = { "cmake", "CMakeLists.txt" },
  init_options = { buildDirectory = "build" },
  single_file_support = true,
  capabilities = capabilities,
  on_attach = on_attach,
}))

lspconfig.rust_analyzer.setup(coq.lsp_ensure_capabilities({
  cmd = { "rust-analyzer" },
  on_attach = on_attach,
  capabilities = capabilities,
}))

--[[
@echo off
java ^
-javaagent:path\to\lombok.jar \
-Declipse.application=org.eclipse.jdt.ls.core.id1 \
-Dosgi.bundles.defaultStartLevel=4 \
-Declipse.product=org.eclipse.jdt.ls.core.product \
-Dlog.protocol=true \
-Dlog.level=ALL \
--add-modules=ALL-SYSTEM \
--add-opens java.base/java.util=ALL-UNNAMED \
--add-opens java.base/java.lang=ALL-UNNAMED \
-Xms4G \
-Xmx4G \
-jar path\to\jdtls\plugins\org.eclipse.equinox.launcher_1.6.*.jar ^
-configuration path\to\jdtls\config_linux\ \
-data "$TEMP\$1"
]]
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local root_marker = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
lspconfig.jdtls.setup(coq.lsp_ensure_capabilities({
  cmd = { 'jdtls', '.workspace_' .. project_name },
  capabilities = capabilities,
  single_file_support = true,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
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

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

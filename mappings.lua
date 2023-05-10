local M = {}

M.LazyGit = {
  n = {
      ["<leader>gg"] = {"<cmd>LazyGit<cr>", "Lazy Git"},
  }
}

M.telescope = {
  plugin = true,
  n = {
      ["<leader>fs"] = {"<cmd>Telescope lsp_document_symbols", "Document Symbols"},
  }
}

M.lspconfig = {
  plugin = true,
  n = {
      ["gr"] = {"<cmd>Telescope lsp_references<cr>", "Lsp References"},
  }
}

return M

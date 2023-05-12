local M = {}

M.LazyGit = {
  n = {
      ["<leader>gg"] = {"<cmd>LazyGit<cr>", "Lazy Git"},
  }
}

M.telescope = {
  n = {
      ["<leader>fs"] = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
  }
}

M.lspconfig = {
  n = {
      ["gr"] = {"<cmd>Telescope lsp_references<cr>", "Lsp References"},
  }
}

return M

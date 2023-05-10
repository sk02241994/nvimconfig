local plugins = {
  {'kdheepak/lazygit.nvim', lazy = false},
  {'mfussenegger/nvim-jdtls'},
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
   "williamboman/mason.nvim",
   opts = {
      ensure_installed = {
        "pyright",
        "typescript-language-server",
        "jdtls",
        "clangd"
      },
    },
  }
}

return plugins
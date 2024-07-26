local plugins = {
  {
    'skywind3000/asyncrun.vim',
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  { "mfussenegger/nvim-jdtls" },
}

return plugins

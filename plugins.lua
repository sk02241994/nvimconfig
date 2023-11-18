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
  {'ms-jpq/coq_nvim'},
}

return plugins

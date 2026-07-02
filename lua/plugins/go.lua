return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              semanticTokens = true,
            },
          },
        },
      },
    },
  },
}

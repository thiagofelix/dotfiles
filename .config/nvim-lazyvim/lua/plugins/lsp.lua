return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = {
          severity = vim.diagnostic.severity.ERROR,
        },
      },
    },
  },
}

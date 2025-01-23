return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      diagnostics = {
        underline = {
          severity = vim.diagnostic.severity.ERROR,
        },
      },
    },
  },
}

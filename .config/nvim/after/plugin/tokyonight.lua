require("tokyonight").setup({
  style = "night",
  on_highlights = function(hl, colors)
    hl.DiagnosticUnnecessary = {
      fg = colors.comment
    }
  end,
  on_colors = function(colors)
    colors.hint = colors.orange
    colors.error = "#ff0000"
  end
})

vim.cmd [[colorscheme tokyonight]]

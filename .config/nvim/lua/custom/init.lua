vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.foldmethod = "indent"
vim.opt.backup = false
vim.opt.swapfile = false

-- Disable folding in Telescope's result window.
vim.api.nvim_create_autocmd("FileType", { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] })
-- Disable folding in NVChat Cheatsheet
vim.api.nvim_create_autocmd("FileType", { pattern = "nvcheatsheet", command = [[setlocal nofoldenable]] })

vim.cmd([[
  augroup onedark
    autocmd!
    autocmd VimEnter * lua _G.toggle_theme()
  augroup END
]])

function _G.toggle_theme()
  local mode = vim.fn.system("defaults read -g AppleInterfaceStyle")
  local theme = vim.g.nvchad_theme
  print(mode)

  if (mode:match("Dark") and theme ~= "everforest") then
    require("base46").toggle_theme()
  end

  if (mode:match("Light") and theme ~= "everforest_light") then
    require("base46").toggle_theme()
  end

end

vim.cmd([[
  augroup filetypes
    autocmd!
    autocmd BufNewFile,BufReadPost *.adl,*.adls,*.adlf setf adl
  augroup END
]])

-- Source adl_colors file using lua
vim.cmd([[source ~/.config/nvim/lua/custom/adl_colors.vim]])

-- vim.lsp.set_log_level 'trace'
-- if vim.fn.has 'nvim-0.5.1' == 1 then
--   require('vim.lsp.log').set_format_func(vim.inspect)
-- end


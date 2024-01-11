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
  local is_dark_mode = mode:match("Dark")
  local is_nvim_dark = vim.g.nvchad_theme == "everforest"
  if not (is_dark_mode and is_nvim_dark) then
    print("Toggling theme")
    require("base46").toggle_theme()
  end
end

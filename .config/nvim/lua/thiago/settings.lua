vim.opt.guicursor = ""
vim.opt.cursorline = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8;
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime       = 50
vim.opt.colorcolumn      = "80"
vim.g.mapleader          = " "
vim.g.maplocalleader     = ","
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize      = 25
vim.o.timeout            = true
vim.o.timeoutlen         = 300
vim.opt.foldmethod       = 'expr'
vim.opt.foldexpr         = 'nvim_treesitter#foldexpr()'

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread           = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- Disable folding in Telescope's result window.
vim.api.nvim_create_autocmd("FileType", { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] })

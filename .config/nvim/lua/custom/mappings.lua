---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- find
    ["<C-p>"] = { "<cmd> Telescope git_files <CR>", "Find git" },
    ["<leader>tt"] = { "<cmd> Telescope<CR>", "Telescope" },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!

return M

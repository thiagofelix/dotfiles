---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "blossom_light",
  theme_toggle = { "blossom_light", "one_light" },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M

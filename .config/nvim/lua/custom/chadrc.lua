---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "everforest" or "everforest",
  theme_toggle = { "everforest", "nightlamp" },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"



return M

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "everforest_light" or "everforest_light",
  theme_toggle = { "everforest_light", "everforest" },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"



return M

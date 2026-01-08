-- File: lua/core/telescope/extensions.lua

local M = {}

M.setup = function(telescope)
	telescope.load_extension("ui-select")
end

return M

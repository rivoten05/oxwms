-- File: lua/core/noice/init.lua

local M = {}

function M.setup()
	local noice = require("noice")
	local config = require("core.noice.config")
	local presets = require("core.noice.presets")

	noice.setup(vim.tbl_extend("force", config, {
		presets = presets,
	}))
end

return M

-- File: lua/core/trouble/init.lua

local M = {}

function M.setup()
	local trouble = require("trouble")
	local opts = require("core.trouble.config")

	trouble.setup(opts)
end

return M

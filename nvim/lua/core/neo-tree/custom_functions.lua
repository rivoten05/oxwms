-- File: lua/core/neo-tree/custom_functions.lua

local M = {}

M.event_handlers = {
	-- Close neo-tree when opening a file.
	{
		event = "file_opened",
		handler = function()
			require("neo-tree").close_all()
		end,
	},
}

return M

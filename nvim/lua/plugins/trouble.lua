-- File: lua/plugins/trouble.lua

local mappings = require("core.trouble.mappings")

return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	cmd = { "Trouble" },
	keys = mappings,
	config = function()
		require("core.trouble").setup()
	end,
}

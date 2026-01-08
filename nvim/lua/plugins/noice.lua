return {
	"folke/noice.nvim",
	event = "VeryLazy",
	cmd = {
		"Noice",
		"NoiceEnable",
		"NoiceDisable",
		"NoiceLog",
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {},
	config = function()
		require("core.noice").setup()
	end,
}

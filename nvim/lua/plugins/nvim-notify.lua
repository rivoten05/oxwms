local icon = require("core.icons")
return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	keys = {
		{
			"<leader>un",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "Dismiss All Notifications",
		},
	},
	opts = {
		stages = "static",
		timeout = 3000,
		icons = {
			ERROR = icon.Error,
			WARN = icon.Warn,
			INFO = icon.Info,
			DEBUG = icon.DEBUG,
			TRACE = icon.TRACE,
		},
		border = "rounded",
	},
}

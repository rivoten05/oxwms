local icon = require("core.icons")
local M = {
	focus = true,
	auto_close = true,
	position = "bottom",
	padding = 2,
	win = {
		border = "rounded",
	},
	signs = {
		error = icon.Error,
		warning = icon.Warn,
		hint = icon.Hint,
		information = icon.Info,
		other = "",
	},
}

return M

local M = {}

function M.setup()
	require("bufferline").setup({
		options = require("core.bufferline.options"),
	})
end

return M

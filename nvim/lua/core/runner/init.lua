local lua_runner = require("core.runner.lua-runner")
local dart_runner = require("core.runner.dart")

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "dart" },
	callback = function(args)
		local runner = (args.match == "lua") and lua_runner or dart_runner

		vim.keymap.set("n", "<leader>bx", runner.eval_buffer, { buffer = args.buf, desc = "Run Buffer" })
		vim.keymap.set("v", "<leader>bx", runner.eval_region, { buffer = args.buf, desc = "Run Selection" })
	end,
})

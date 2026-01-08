local M = {}

function M.setup(dashboard)
	vim.api.nvim_create_autocmd("User", {
		once = true,
		pattern = "LazyVimStarted",
		callback = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			dashboard.section.footer.val = " Neovim loaded "
				.. stats.loaded
				.. "/"
				.. stats.count
				.. " plugins in "
				.. ms
				.. "ms"
			pcall(vim.cmd.AlphaRedraw)
		end,
	})
end

return M

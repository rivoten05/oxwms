return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		if vim.fn.argc() > 0 then
			return
		end

		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		require("core.alpha.theme").setup(dashboard)
		require("core.alpha.footer").setup(dashboard)
		require("core.alpha.autocmds").setup()

		alpha.setup(dashboard.opts)
	end,
}

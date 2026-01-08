return {
	"saghen/blink.cmp",
	event = { "BufReadPre", "BufNewFile" },
	version = "v0.*",
	dependencies = {
		{ "saghen/blink.compat", opts = { enable_events = true } },
		{
			"Exafunction/codeium.nvim",
			event = "InsertEnter",
			config = function()
				require("codeium").setup({}) -- Minimal setup call
			end,
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
			event = "InsertEnter",
			dependencies = { "rafamadriz/friendly-snippets" },
			opts = {},
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load({
					paths = vim.fn.stdpath("config") .. "/snippets",
				})
			end,
		},
	},
	config = function()
		require("core.blink").setup()
	end,
}

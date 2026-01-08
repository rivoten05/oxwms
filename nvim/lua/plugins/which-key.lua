return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		timeout = 500,
		win = {
			border = "rounded",
			padding = { 1, 2, 1, 2 },
		},
		layout = {
			align = "center",
		},
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			-- You can also add more here, e.g., for macros or other features
			-- https://github.com/folke/which-key.nvim#plugins
		},
	},
	keys = {
		-- Show buffer-local keymaps
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps",
		},

		-- Show global keymaps (e.g., all your leader mappings)
		{
			"<leader>wk",
			function()
				require("which-key").show({ global = true })
			end,
			desc = "All Global Keymaps",
		},

		-- Search for a keymap prefix
		{
			"<leader>w?",
			function()
				require("which-key").show(nil, { mode = "n" })
			end,
			desc = "WhichKey Look-up",
		},
	},
}

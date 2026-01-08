-- File: lua/plugins/lsp.lua

return {
	-- 1. Mason plugin for managing LSP servers
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
				},
			})
		end,
	},

	-- 2. Mason-Lspconfig for easy server integration
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		cmd = { "LspInstall", "LspUninstall" },
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			auto_install = true,
		},
	},

	-- 3. nvim-lspconfig for the actual LSP setup
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		opts = { diagnostics = { virtual_text = false } },
		config = function()
			require("core.lsp").setup()
		end,
	},

	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		opts = {
			preset = "modern",
			transparent_bg = true,
		},
	},
}

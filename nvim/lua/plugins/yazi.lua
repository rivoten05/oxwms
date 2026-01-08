return {
	"mikavilpas/yazi.nvim",
	cmd = { "Yazi" },
	version = "*", -- use the latest stable version
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	keys = {
		{
			"-",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		{
			-- Open in the current working directory
			"<leader>wd",
			"<cmd>Yazi cwd<cr>",
			desc = "Open the file manager in nvim's working directory",
		},
		{
			"<c-S-up>",
			"<cmd>Yazi toggle<cr>",
			desc = "Resume the last yazi session",
		},
	},
	opts = {
		open_for_directories = false,
		hijack_netrw = true,
		floating_window_border = "rounded",
		keymaps = {
			show_help = "<f1>",
			grep_in_directory = "<c-s>",
		},
	},
}

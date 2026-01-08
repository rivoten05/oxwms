return {
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			transparent = false,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			on_colors = function(colors)
				colors.bg_statusline = "NONE"
			end,
		},
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = true,
		opts = {
			variant = "auto",
			transparent = false,
			italic_comments = true,
			borderless_pickers = false,
			highlights = {
				Comment = { fg = "#9c9c9c", bg = "NONE", italic = true },
			},
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = true,
		opts = {
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
				loops = true,
				functions = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		},
	},
}

return {
	"catppuccin/nvim",
	-- priority = 1000,
	lazy = true,
	name = "catppuccin",
	opts = {
		transparent_background = false,
		flavour = "macchiato", -- latte, frappe, macchiato, mocha
		background = { -- :h background
			dark = "macchiato",
		},
		float = {
			transparent = true, -- enable transparent floating windows
			solid = true, -- use solid styling for floating windows, see |winborder|
		},
		dim_inactive = {
			enabled = false, -- dims the background color of inactive window
			shade = "dark",
			percentage = 0.15, -- percentage of the shade to apply to the inactive window
		},
		styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
			comments = { "italic" }, -- Change the style of comments
			conditionals = { "italic" },
			loops = { "bold" },
			functions = { "bold" },
			keywords = { "bold" },
			strings = { "italic" },
			variables = { "italic" },
			numbers = { "italic" },
			booleans = { "italic" },
			properties = { "bold" },
			types = { "bold" },
			operators = { "bold" },
		},
		integrations = {
			alpha = true,
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			dashboard = true,
			flash = true,
			treesitter = true,
			notify = true,
			neotree = true,
			mason = true,
			noice = true,
			navic = { enabled = true, custom_bg = "lualine" },
			native_lsp = {
				enabled = true,
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
			neotest = true,
			semantic_tokens = true,
			snacks = true,
			telescope = true,
			treesitter_context = true,
			which_key = true,
			lsp_trouble = true,
			mini = {
				enabled = true,
				indentscope_color = "lavender",
			},
			blink_cmp = {
				style = "bordered",
			},
			indent_blankline = {
				enabled = true,
				scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
				colored_indent_levels = true,
			},
		},
	},
}

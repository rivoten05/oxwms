-- File: lua/core/telescope/config.lua

local M = {
	sort_mru = true,
	sort_lastused = true,
	ignore_current_buffer = true,
	pickers = {
		buffers = { sort_lastused = true },
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
	defaults = {
		border = true,
		borderchars = {
			prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		},
		initial_mode = "insert",
		prompt_prefix = "   ",
		selection_caret = "  ",
		multi_icon = " 󰄱 ",
		entry_prefix = " ",
		path_display = { "truncate" },
		file_ignore_patterns = {
			"node_modules",
			".git/",
			".DS_Store",
			"*.log",
			"*.tmp",
			"*.swp",
			"dist/",
			"build/",
			".next/",
			".nuxt/",
			".vuepress/",
		},
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.70,
			},
			width = 0.87,
			height = 0.80,
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
			"--glob",
			"!{.git,node_modules,.DS_Store}",
		},
	},
}

return M

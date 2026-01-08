-- File: lua/core/neo-tree/config.lua

local M = {}

-- Define a central location for all icons
local icons = {
	folder = {
		closed = " ",
		open = " ",
		empty = "",
		empty_open = "",
		default = "",
	},
	git = {
		added = " ",
		deleted = " ",
		modified = " ",
		renamed = " ",
		untracked = " ",
		ignored = " ",
		unstaged = " ",
		staged = " ",
		conflict = " ",
	},
	modified = " ",
	source = {
		files = "  Files",
		buffers = "  Buffers",
		git_status = " 󰊢 Git",
	},
}

M.options = {
	close_if_last_window = true,
	popup_border_style = "rounded",
	sort_case_insensitive = true,
	follow_current_file = {
		enabled = true,
		leave_dirs_open = false,
	},
	group_empty_dirs = true,
	auto_expand_width = false,
}

M.source_selector = {
	winbar = false,
	show_scrolled_off_parent_node = true,
	padding = { left = 1, right = 0 },
	sources = {
		{ source = "filesystem", display_name = icons.source.files },
		{ source = "buffers", display_name = icons.source.buffers },
		{ source = "git_status", display_name = icons.source.git_status },
	},
}

M.component_configs = {
	indent = { with_expanders = false },
	icon = {
		folder_closed = icons.folder.closed,
		folder_open = icons.folder.open,
		folder_empty = icons.folder.empty,
		folder_empty_open = icons.folder.empty_open,
		default = icons.folder.default,
	},
	modified = { symbol = icons.modified },
	name = {
		trailing_slash = true,
		highlight_opened_files = true,
		use_git_status_colors = false,
	},
	git_status = {
		symbols = icons.git,
	},
}

M.window = {
	width = 35,
	winblend = 10,
	position = "left",
}

M.filters = {
	hide_dotfiles = false,
	hide_gitignored = false,
	hide_by_name = {
		".git",
		".hg",
		".svc",
		".DS_Store",
		"thumbs.db",
		".sass-cache",
		"node_modules",
		".pytest_cache",
		".mypy_cache",
		"__pycache__",
		".stfolder",
		".stversions",
		".next",
		".nuxt",
		".vuepress",
		".cache",
		".parcel-cache",
	},
	never_show = {
		".DS_Store",
		"thumbs.db",
	},
}

return M

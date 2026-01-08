-- File: lua/core/telescope/mappings.lua

local actions = require("telescope.actions")

local M = {
	i = {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-n>"] = actions.cycle_history_next,
		["<C-p>"] = actions.cycle_history_prev,
		["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
		["<C-l>"] = actions.complete_tag,
		["<C-_>"] = actions.which_key,
		["<C-w>"] = { "<c-s-w>", type = "command" },
		["<C-h>"] = "which_key",
		["<esc>"] = actions.close,
	},
	n = {
		["q"] = actions.close,
		["<C-n>"] = actions.move_selection_next,
		["<C-p>"] = actions.move_selection_previous,
		["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
		["<C-c>"] = actions.close,
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<C-h>"] = "which_key",
	},
}

return M

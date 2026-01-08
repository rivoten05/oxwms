-- File: lua/core/neo-tree/init.lua

local M = {}

function M.setup()
	local neo_tree = require("neo-tree")

	-- Load individual configuration modules
	local config = require("core.neo-tree.config")
	local custom_functions = require("core.neo-tree.custom_functions")
	local mappings = require("core.neo-tree.mappings")

	-- Set up Neo-tree by merging all the configurations
	neo_tree.setup({
		-- General options
		close_if_last_window = config.options.close_if_last_window,
		popup_border_style = config.options.popup_border_style,
		sort_case_insensitive = config.options.sort_case_insensitive,
		follow_current_file = config.options.follow_current_file,
		group_empty_dirs = config.options.group_empty_dirs,
		auto_expand_width = config.options.auto_expand_width,

		-- Source selector
		source_selector = config.source_selector,

		-- Component configurations
		default_component_configs = config.component_configs,

		-- Window and mappings
		window = vim.tbl_extend("force", config.window, {
			mappings = mappings,
		}),

		-- Filters
		filtered_items = config.filters,

		-- Event handlers
		event_handlers = custom_functions.event_handlers,
	})
end

return M

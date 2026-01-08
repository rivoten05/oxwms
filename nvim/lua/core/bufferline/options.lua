return {
	indicator = {
		icon = "☕",
		style = "icon",
	},
	offsets = {
		{
			filetype = "neo-tree",
			text = "Neo-tree",
			highlight = "Directory",
			separator = false,
			padding = 0,
		},
	},
	diagnostics = "nvim_lsp",
	always_show_bufferline = true,
	diagnostics_indicator = function(_, _, diag)
		local icons = {
			Error = " ",
			Warn = " ",
			Hint = " ",
			Info = " ",
		}
		local ret = (diag.error and icons.Error .. diag.error .. " " or "")
			.. (diag.warning and icons.Warn .. diag.warning or "")
		return vim.trim(ret)
	end,
	mode = "buffers",
	buffer_close_icon = "",
	close_icon = "-",
	modified_icon = "●",
	left_trunc_marker = "",
	right_trunc_marker = "",
	max_name_length = 18,
	max_prefix_length = 15,
	tab_size = 20,
	separator_style = "thick",
	enforce_regular_tabs = true,
	color_icons = true,
	show_buffer_close_icons = true,
	show_close_icon = true,
	show_tab_indicators = true,
	persist_buffer_sort = true,
}

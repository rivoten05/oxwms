return {
	"saghen/blink.indent",
	version = "*",
	dependencies = {
		"saghen/blink.download",
	},
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("blink.indent").setup({
			blocked = {
				buftypes = { include_defaults = true },
				filetypes = {
					include_defaults = true,
					"NvimTree",
					"Trouble",
					"trouble",
					"neo-tree",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
			-- mappings = {
			--     border = 'both',
			--     object_scope = 'ii',
			--     object_scope_with_border = 'ai',
			--     goto_top = '[i',
			--     goto_bottom = ']i',
			-- },
			-- static = {
			--     enabled = true,
			--     char = '▎',
			--     highlights = { 'BlinkIndent' },
			-- },
			scope = {
				enabled = true,
				char = "▎",
				highlights = { "BlinkIndentGreen", "BlinkIndentViolet", "BlinkIndentBlue" },
				-- highlights = { 'BlinkIndentRed', 'BlinkIndentCyan', 'BlinkIndentYellow', 'BlinkIndentGreen' },
			},
		})
	end,
}

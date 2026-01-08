return {
	default = { "lsp", "codeium", "path", "snippets", "buffer" },
	providers = {
		codeium = {
			name = "codeium",
			module = "blink.compat.source",
			score_offset = 100,
			async = true,
			transform_items = function(_, items)
				for _, item in ipairs(items) do
					item.kind = vim.lsp.protocol.CompletionItemKind.Event
					item.kind_name = "Codeium"
				end
				return items
			end,
		},
	},
}

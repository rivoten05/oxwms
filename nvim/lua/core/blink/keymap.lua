return {
	["<C-z>"] = { "select_and_accept" },
	["<Tab>"] = {
		function(cmp)
			if cmp.is_visible() then
				return cmp.select_next()
			end
			if cmp.snippet_active() then
				return cmp.snippet_forward()
			end
			return false -- fallbacks to normal tab
		end,
		"fallback",
	},

	["<S-Tab>"] = {
		function(cmp)
			if cmp.is_visible() then
				return cmp.select_prev()
			end
			if cmp.snippet_active() then
				return cmp.snippet_backward()
			end
			return false
		end,
		"fallback",
	},

	["<Up>"] = { "select_prev", "fallback" },
	["<Down>"] = { "select_next", "fallback" },

	["<C-f>"] = { "scroll_documentation_up", "fallback" }, -- C-f/b is standard for scrolling
	["<C-b>"] = { "scroll_documentation_down", "fallback" },

	["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
	["<C-e>"] = { "hide", "fallback" },
}

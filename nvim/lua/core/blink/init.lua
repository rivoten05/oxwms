local M = {}

function M.setup()
	local opts = {
		keymap = require("core.blink.keymap"),
		appearance = require("core.blink.appearance"),
		snippets = require("core.blink.snippets"),
		sources = require("core.blink.sources"),
		fuzzy = {
			use_frecency = true,
			use_proximity = true,
			implementation = "prefer_rust_with_warning",
			sorts = { "score", "sort_text" },
		},
		completion = {
			trigger = {
				prefetch_on_insert = false,
				show_on_trigger_character = true,
			},
			ghost_text = {
				enabled = true,
				show_without_selection = true,
			},
			menu = {
				border = "rounded",
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
					},
					components = {
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								return ctx.kind_icon .. ctx.icon_gap
							end,
							highlight = function(ctx)
								if ctx.item.source_name == "codeium" then
									return "BlinkCmpKindCodeium"
								end
								return "BlinkCmpKind" .. ctx.kind
							end,
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = { border = "rounded" },
			},
		},
		signature = { enabled = true, window = { border = "rounded" } },
		cmdline = {
			keymap = {
				["<Tab>"] = { "show", "accept" },
			},
			completion = {
				menu = {
					auto_show = true,
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
						},
					},
				},
			},
		},
	}

	require("blink.cmp").setup(opts)
end

return M

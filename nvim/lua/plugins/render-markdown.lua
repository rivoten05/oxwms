return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = "markdown",
	opts = {
		heading = { position = "inline", width = "block"
 },
		latex = { enabled = false },
		checkbox = {
			checked = { icon = "✔ ", scope_highlight = "@markup.strikethrough" },
			unchecked = { icon = "✘ " },
			custom = {
				important = {
					raw = "[~]",
					rendered = "󰓎 ",
					highlight = "DiagnosticWarn",
				},
			},
		},
		code = { style = "language", width = "block" },
		pipe_table = { preset = "round" },
		link = {
			email = " ",
			custom = {
				python = {
					pattern = "%.py$",
					icon = "󰌠 ",
				},
			},
		},
	},
}

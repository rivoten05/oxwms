return {
	"numToStr/Comment.nvim",
	opts = {
		toggler = {
			line = "gtc",
			block = "gtb",
		},
		opleader = {
			line = "goc",
			block = "gob",
		},
	},
	keys = {
		{ "gtc", mode = { "n", "v" } }, -- Toggler for lines
		{ "gtb", mode = { "n", "v" } }, -- Toggler for blocks
		{ "goc", mode = "n" }, -- Opleader for lines
		{ "gob", mode = "n" }, -- Opleader for blocks
	},
}

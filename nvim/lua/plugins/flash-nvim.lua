return {
	"folke/flash.nvim",
	keys = {
		{
			"<leader>ss",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<A-s>",
			mode = "c",
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
	config = function(_, opts)
		require("flash").setup(opts)
	end,
}

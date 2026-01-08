-- File: lua/core/trouble/mappings.lua

local M = {
	-- Basic keybindings
	{ "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
	{
		"<leader>xd",
		"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
		desc = "Open trouble document diagnostics",
	},
	{ "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list" },
	{ "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
	{ "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },

	-- Navigation functions
	{
		"[q",
		function()
			if require("trouble").is_open() then
				require("trouble").prev({ skip_groups = true, jump = true })
			else
				local ok, err = pcall(vim.cmd.cprev)
				if not ok then
					vim.notify(err, vim.log.levels.ERROR)
				end
			end
		end,
		desc = "Previous Trouble/Quickfix Item",
	},
	{
		"]q",
		function()
			if require("trouble").is_open() then
				require("trouble").next({ skip_groups = true, jump = true })
			else
				local ok, err = pcall(vim.cmd.cnext)
				if not ok then
					vim.notify(err, vim.log.levels.ERROR)
				end
			end
		end,
		desc = "Next Trouble/Quickfix Item",
	},
}

return M

-- File: lua/core/telescope/custom_functions.lua

local builtin = require("telescope.builtin")
local M = {}

M.find_files_cwd = function()
	builtin.find_files({
		cwd = vim.fn.expand("%:p:h"),
		hidden = true,
	})
end

M.live_grep_cwd = function()
	builtin.live_grep({
		cwd = vim.fn.expand("%:p:h"),
		additional_args = function()
			return { "--hidden", "--glob", "!{.git,node_modules,.DS_Store}" }
		end,
	})
end

M.grep_word_under_cursor = function()
	builtin.grep_string({
		search = vim.fn.expand("<cword>"),
		additional_args = function()
			return { "--hidden", "--glob", "!{.git,node_modules,.DS_Store}" }
		end,
	})
end

return M

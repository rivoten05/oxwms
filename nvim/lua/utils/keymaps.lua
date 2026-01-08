local M = {}

local map = vim.keymap.set

--- @param mode string The Vim mode (e.g., 'n', 'v', 'i')
--- @param lhs string The left-hand side key combination (e.g., '<leader>ld')
--- @param rhs_func function The function to call (e.g., vim.lsp.buf.definition)
--- @param desc string The description for the keymap
function M.safe_map(mode, lhs, rhs_func, desc) -- <-- RENAME HERE
	map(mode, lhs, function()
		local ok, _ = pcall(rhs_func)
		if not ok then
			local command_name = desc:match("([^%s]+)$") or "Command"
			vim.notify(command_name .. " not available", vim.log.levels.WARN, { title = "Keymap Error" })
		end
	end, { desc = desc })
end

--- @param mode string The Vim mode (e.g., 'n', 'v', 'i')
--- @param lhs string The left-hand side key combination
--- @param rhs string The right-hand side string/command
--- @param desc string The description for the keymap
function M.basic_map(mode, lhs, rhs, desc)
	map(mode, lhs, rhs, { desc = desc })
end

return M

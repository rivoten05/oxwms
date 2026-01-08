local M = {}

function M.setup()
	local servers = require("core.lsp.servers")
	local capabilities = require("blink.cmp").get_lsp_capabilities()

	for _, lsp in ipairs(servers) do
		local config = vim.lsp.config[lsp] or {}
		config.capabilities = capabilities
		vim.lsp.enable(lsp)
	end

	local icons = require("core.icons")
	vim.diagnostic.config({
		virtual_text = false,
		virtual_lines = false,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			border = "rounded",
			source = true,
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = icons.Error,
				[vim.diagnostic.severity.WARN] = icons.Warn,
				[vim.diagnostic.severity.INFO] = icons.Info,
				[vim.diagnostic.severity.HINT] = icons.Hint,
			},
			numhl = {
				[vim.diagnostic.severity.ERROR] = "ErrorMsg",
				[vim.diagnostic.severity.WARN] = "WarningMsg",
			},
		},
	})
end

return M

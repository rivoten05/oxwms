-- File: lua/core/conform.lua

local M = {}

M.setup = function()
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_fix", "ruff_format" },
			go = { "gofumpt", "goimports" },
			rust = { "rustfmt" },
			dart = { "dartls" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	})
end

return M

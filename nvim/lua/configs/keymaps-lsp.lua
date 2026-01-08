local util = require("utils.keymaps")

local lsp_map = util.safe_map

-- Go to Definition
lsp_map("n", "<leader>ld", vim.lsp.buf.definition, "Go to Definition")
lsp_map("n", "gd", vim.lsp.buf.definition, "Go to Definition (Quick)")

-- Go to Type Definition
lsp_map("n", "<leader>lt", vim.lsp.buf.type_definition, "Go to Type Definition")

-- Go to Implementation
lsp_map("n", "<leader>lI", vim.lsp.buf.implementation, "Go to Implementation")
lsp_map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation (Quick)")

-- Find References
lsp_map("n", "<leader>lr", vim.lsp.buf.references, "Find References")
lsp_map("n", "gr", vim.lsp.buf.references, "Find References (Quick)")

-- Rename Symbol
lsp_map("n", "<leader>ln", vim.lsp.buf.rename, "Rename Symbol")

-- Code Actions
local code_action_func = function()
	-- Using a wrapper function to ensure compatibility with lsp_map
	return vim.lsp.buf.code_action()
end
lsp_map("n", "<leader>la", code_action_func, "Code Actions")
lsp_map("v", "<leader>la", code_action_func, "Code Actions (Visual)")
-- NOTE: The quick fix map was similar to code actions, keeping only the standard <leader>la

-- Hover Documentation
lsp_map("n", "<leader>lk", vim.lsp.buf.hover, "Hover Documentation")
lsp_map("n", "K", vim.lsp.buf.hover, "Hover Documentation (Quick)")

-- Signature Help
lsp_map("n", "<leader>lK", vim.lsp.buf.signature_help, "Signature Help")

-- Format Document
lsp_map("n", "<leader>lf", function()
	return vim.lsp.buf.format({ async = true })
end, "Format Document")

-- Format Selection (Visual mode)
lsp_map("v", "<leader>lf", function()
	return vim.lsp.buf.format({ async = true })
end, "Format Selection")

-- Toggle Inlay Hints
lsp_map("n", "<leader>lh", function()
	-- Explicitly defining the function to toggle inlay hints
	return vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, "Toggle Inlay Hints")

-- Code Lens
lsp_map("n", "<leader>lc", vim.lsp.codelens.run, "Run Code Lens")
lsp_map("n", "<leader>lC", vim.lsp.codelens.refresh, "Refresh Code Lens")

-- Document Symbols (requires Telescope)
lsp_map("n", "<leader>ls", function()
	return vim.cmd("Telescope lsp_document_symbols")
end, "Document Symbols (Telescope)")

-- Workspace Symbols (requires Telescope)
lsp_map("n", "<leader>lS", function()
	return vim.cmd("Telescope lsp_workspace_symbols")
end, "Workspace Symbols (Telescope)")

-- Incoming/Outgoing Calls (requires Telescope)
lsp_map("n", "<leader>lo", function()
	return vim.cmd("Telescope lsp_outgoing_calls")
end, "Outgoing Calls (Telescope)")
-- NOTE: Duplicated <leader>lI keymap is removed. Use a unique key for Incoming Calls.
lsp_map("n", "<leader>li", function() -- Changed to <leader>li (lowercase 'i')
	return vim.cmd("Telescope lsp_incoming_calls")
end, "Incoming Calls (Telescope)")

-- Previous Diagnostic
lsp_map("n", "<leader>dp", vim.diagnostic.goto_prev, "Previous Diagnostic")

-- Next Diagnostic
lsp_map("n", "<leader>dn", vim.diagnostic.goto_next, "Next Diagnostic")

-- Show Diagnostic under cursor
lsp_map("n", "<leader>dd", vim.diagnostic.open_float, "Show Diagnostic")

-- List All Diagnostics (Telescope)
lsp_map("n", "<leader>dl", function()
	return vim.cmd("Telescope diagnostics")
end, "List All Diagnostics (Telescope)")

-- List Buffer Diagnostics (Telescope)
lsp_map("n", "<leader>dL", function()
	return vim.cmd("Telescope diagnostics bufnr=0")
end, "List Buffer Diagnostics (Telescope)")

-- Send Diagnostics to Loclist
lsp_map("n", "<leader>dq", vim.diagnostic.setloclist, "Send Diagnostics to Loclist")

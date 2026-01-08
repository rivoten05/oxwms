local util = require("utils.keymaps")
local safe_map = util.safe_map -- The safe-calling map function

local builtin = require("telescope.builtin")

-- ## 🔭 Telescope - Search & Find Operations

-- Find Files
safe_map("n", "<leader>ff", builtin.find_files, "Find Files")

-- Find Notifications (History)
safe_map("n", "<leader>fu", function()
	require("telescope").extensions.notify.notify()
end, "Find Notifications (History)")

-- Smart Open Files (requires Telescope Smart Open extension)
safe_map("n", "<leader>fF", function()
	-- Assuming Telescope is loaded and extension is available
	local telescope = require("telescope")
	return telescope.extensions.smart_open.smart_open()
end, "Smart Open Files")

-- Live Grep (Search in Project)
safe_map("n", "<leader>fg", builtin.live_grep, "Live Grep (Project)")

-- Live Grep in Current Directory
safe_map("n", "<leader>fG", function()
	return builtin.live_grep({ cwd = vim.fn.expand("%:p:h") })
end, "Live Grep (Directory)")

-- Find Buffers
safe_map("n", "<leader>fb", builtin.buffers, "Find Buffers")

-- Find Old Files / Recent files
safe_map("n", "<leader>fo", builtin.oldfiles, "Find Old Files")
safe_map("n", "<leader>bh", builtin.oldfiles, "Recent Files")

-- Resume Last Search
safe_map("n", "<leader>fr", builtin.resume, "Resume Last Search")

-- Fuzzy Find in Current Buffer / Quick Search
safe_map("n", "<leader>fz", builtin.current_buffer_fuzzy_find, "Fuzzy Find in Current Buffer")
safe_map("n", "<leader>?", builtin.current_buffer_fuzzy_find, "Search in Current Buffer")

-- Find Help Tags
safe_map("n", "<leader>fh", builtin.help_tags, "Find Help Tags")

-- Find Man Pages
safe_map("n", "<leader>fm", builtin.man_pages, "Find Man Pages")

-- Find Keymaps
safe_map("n", "<leader>fk", builtin.keymaps, "Find Keymaps")

-- Find Commands
safe_map("n", "<leader>fc", builtin.commands, "Find Commands")

-- List File Types
safe_map("n", "<leader>bt", builtin.filetypes, "List File Types")

-- Find string under cursor (Default setting uses '<cword>')
safe_map("n", "<leader>ft", builtin.grep_string, "Find String Under Cursor")

-- Find Word Under Cursor (Explicit <cword> search)
safe_map("n", "<leader>fT", function()
	return builtin.grep_string({ search = vim.fn.expand("<cword>") })
end, "Find Word Under Cursor")
safe_map("n", "<leader>sw", function()
	return builtin.grep_string({ search = vim.fn.expand("<cword>") })
end, "Search Word Under Cursor")

-- Find Symbols (e.g., tags)
safe_map("n", "<leader>fs", builtin.symbols, "Find Symbols")

-- Find Workspace Symbols
safe_map("n", "<leader>fS", builtin.lsp_workspace_symbols, "Find Workspace Symbols")

-- Search in Project (Live Grep)
safe_map("n", "<leader>/", builtin.live_grep, "Search in Project")
safe_map("n", "<leader>sp", builtin.live_grep, "Search in Project")

-- Search Word Under Cursor (using <cword>)
safe_map("n", "<leader>*", function()
	return builtin.grep_string({ search = vim.fn.expand("<cword>") })
end, "Search Word Under Cursor")

-- Search Visual Selection (Safe & Reliable)
safe_map("v", "<leader>fv", function()
	local function get_visual_selection()
		vim.cmd('noau normal! "vy')
		local text = vim.fn.getreg("v")
		vim.fn.setreg("v", {})
		return text
	end
	builtin.grep_string({ search = get_visual_selection() })
end, "Search Visual Selection")

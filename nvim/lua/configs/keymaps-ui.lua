local util = require("utils.keymaps")
local basic_map = util.basic_map
local safe_map = util.safe_map

basic_map("n", "<leader>h", "<cmd>Alpha<CR>", "Alpha")

basic_map("n", ";", ":", "Esc")

-- Reload nvim (LINE 8/9 area)
basic_map("n", "<leader>ur", "<Cmd>update<CR><Cmd>source<CR>", "Reload nvim")

safe_map("n", "<leader>ut", function()
	require("telescope.builtin").colorscheme({
		enable_preview = true,
		previewer = false,
		layout_config = {
			width = 0.3,
			height = 0.5,
		},
		ignore_builtins = true,
	})
end, "Telescope: Colorscheme Picker (Live Preview)")

-- Show Lazy logs
basic_map("n", "<leader>pl", "<cmd>Lazy log<CR>", "Show Lazy logs")

-- Check plugin health
basic_map("n", "<leader>ph", "<cmd>Lazy health<CR>", "Check plugin health")

-- Show recent messages (Vim messages)
basic_map("n", "<leader>pm", "<cmd>messages<CR>", "Show recent messages")

-- Show startup time (LINE 24 area)
safe_map("n", "<leader>pt", function()
	local stats = require("lazy").stats()
	local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
	vim.notify(
		string.format("⚡ Neovim loaded %d/%d plugins in %s ms", stats.loaded, stats.count, ms),
		vim.log.levels.INFO,
		{ title = "Lazy Startup" }
	)
end, "Show startup time")

-- Copy current file path (LINE 44 area)
safe_map("n", "<leader>Hp", function()
	vim.fn.setreg("+", vim.fn.expand("%:p"))
	vim.notify("Copied: " .. vim.fn.expand("%:p"), vim.log.levels.INFO, { title = "Path Copy" })
end, "Copy current file path")

-- Copy current file directory (LINE 50 area)
safe_map("n", "<leader>HP", function()
	vim.fn.setreg("+", vim.fn.expand("%:p:h"))
	vim.notify("Copied: " .. vim.fn.expand("%:p:h"), vim.log.levels.INFO, { title = "Path Copy" })
end, "Copy current file directory")

-- ... (rest of the code) ...
-- Quick access to important files
local builtin = require("telescope.builtin")
-- Using safe_map here just in case Telescope is not loaded, though basic_map is also sufficient.
safe_map("n", "<leader>fN", function()
	builtin.find_files({ cwd = "~/.config/nvim" })
end, "Edit Neovim Config (Telescope)")

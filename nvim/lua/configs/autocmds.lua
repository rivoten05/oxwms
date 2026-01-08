if vim.g.colors_name == nil then
	vim.cmd("colorscheme gruvbox")
end

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("no_auto_comment", { clear = true }),
	callback = function()
		-- remove c, r, o locally
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

vim.api.nvim_create_augroup("LualineThemeReload", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
	group = "LualineThemeReload",
	pattern = "*",
	callback = function()
		local ok, lualine_module = pcall(require, "core.lualine")
		if ok then
			lualine_module.setup()
			vim.cmd("redraw!")
		end
	end,
})

local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- make buffer and lualine transparent
-- vim.api.nvim_create_autocmd({ "UiEnter", "ColorScheme" }, {
-- 	callback = function()
-- 		-- 1.
-- 		vim.cmd([[
--       hi TabLineFill gui=nocombine
--       hi WinBar gui=nocombine
--     ]])
-- 		-- 2.
-- 		vim.cmd([[
--       hi TabLineFill guibg=none
--       hi WinBar gui=none
--     ]])
-- 		-- 3.
-- 		vim.cmd([[
--       hi! link TabLineFill Normal
--       hi! link WinBar Normal
--     ]])
-- 		--4.
-- 		vim.cmd("hi StatusLine guibg=NONE ctermbg=NONE")
-- 	end,
-- })

-- Dim inactive windows
-- vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.wo.winhighlight = "Normal:Normal,NormalNC:Normal"
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.wo.winhighlight = "Normal:ColorColumn,NormalNC:ColorColumn"
-- 	end,
-- })

-- Show relative line numbers in normal mode, absolute in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	pattern = "*",
	command = "setlocal norelativenumber",
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	pattern = "*",
	command = "setlocal relativenumber",
})

vim.api.nvim_create_user_command("ToggleContrast", function()
	if vim.g.gruvbox_contrast_dark == "hard" then
		vim.g.gruvbox_contrast_dark = "medium"
		print("Contrast: Medium")
	else
		vim.g.gruvbox_contrast_dark = "hard"
		print("Contrast: Hard")
	end
	vim.cmd("colorscheme gruvbox")
end, {})

vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Comment" })

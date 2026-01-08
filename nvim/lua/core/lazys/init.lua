-- Startup profiling (run with NVIM_PROFILE=1 nvim to enable)
if vim.env.NVIM_PROFILE then
	require("plenary.profile").start("profile.log", { flame = true })
	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			require("plenary.profile").stop()
		end,
	})
end

require("configs.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"spellfile_plugin",
				"man",
			},
		},
		reset_packpath = true,
		cache = {
			enabled = true,
			path = vim.fn.stdpath("cache") .. "/lazy/cache",
			compress = true,
		},
		checker = {
			enabled = false, -- Disable automatic check for plugin updates
		},
		change_detection = {
			notify = false, -- Don't notify when config files change
		},
		-- Additional performance optimizations
		profiling = {
			-- Only load loader and build profiles if NVIM_PROFILE is set
			loader = vim.env.NVIM_PROFILE ~= nil,
			require = vim.env.NVIM_PROFILE ~= nil,
		},
	},
	ui = {
		size = { width = 0.8, height = 0.8 },
		wrap = true, -- wrap the lines in the ui
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "rounded",
		-- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
		backdrop = 100,
		title = nil, ---@type string only works when border is not "none"
		title_pos = "center", ---@type "center" | "left" | "right"
		-- Show pills on top of the Lazy window
		pills = true, ---@type boolean
		icons = {
			cmd = " ",
			config = "",
			debug = "● ",
			event = " ",
			favorite = " ",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			lazy = "󰒲 ",
			loaded = "●",
			not_loaded = "○",
			plugin = " ",
			runtime = " ",
			require = "󰢱 ",
			source = " ",
			start = " ",
			task = "✔ ",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
	},
})

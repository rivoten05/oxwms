local opt = vim.opt
local g = vim.g

-- Neovide settings (cleaner and more consistent)
if g.neovide then
	g.neovide_opacity = 0.8
	g.neovide_cursor_animation_length = 0.13
	g.neovide_cursor_trail_length = 0.00
	g.neovide_cursor_trail_size = 0.3
	g.neovide_cursor_vfx_mode = "railgun"
	g.neovide_remember_window_size = true -- Use the more modern option

	-- neovide padding (can be simplified if all are 0)
	g.neovide_padding_top = 0
	g.neovide_padding_bottom = 0
	g.neovide_padding_right = 0
	g.neovide_padding_left = 0

	-- Scroll and refresh rate
	g.neovide_scroll_animation_length = 0.3
	g.neovide_refresh_rate = 60

	-- Floating window corner radius (consider a small value for a modern look)
	g.neovide_floating_corner_radius = 8

	-- macOS only
	g.neovide_show_border = false

	-- Hide mouse when typing
	g.neovide_hide_mouse_when_typing = true
	g.neovide_theme = "auto"

	-- Font rendering and scaling (optional but can be useful)
	g.neovide_text_gamma = 0.8
end

----------------------------------- General Options ------------------------------------

-- Swap file and undo
opt.swapfile = false
opt.undofile = true
opt.undolevels = 1000 -- Store more undo history

-- Status line and UI
opt.laststatus = 3
opt.showmode = false
opt.fillchars = { eob = " ", vert = "│" } -- Better visual separation
opt.signcolumn = "yes"
opt.mouse = "a"

-- Clipboard
opt.clipboard = "unnamedplus"

-- Cursor and line numbers
opt.cursorline = true
opt.cursorlineopt = "number"
opt.number = true -- Absolute line numbers
opt.relativenumber = true -- Relative line numbers for easier navigation
opt.numberwidth = 2
opt.ruler = false

-- Indenting and tabs
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- Searching
opt.ignorecase = true
opt.smartcase = true

-- Split windows
opt.splitbelow = true
opt.splitright = true

-- Timeouts and updates
opt.timeoutlen = 400
opt.updatetime = 250

-- Wrappings and navigation
opt.whichwrap:append("<>[]hl")

-- Disable default providers (more efficient)
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Global variables
g.mapleader = " "

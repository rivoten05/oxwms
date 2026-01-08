local util = require("utils.keymaps")
-- Use the new basic_map for reliable, non-pcall commands
local basic_map = util.basic_map

-- ## 🖱️ Core Navigation & Movement
-- Disable space in normal mode
basic_map("n", "<Space>", "<Nop>", "Disable Space")

-- Better window navigation (panes) with Ctrl + h/j/k/l
basic_map("n", "<C-h>", "<C-w>h", "Window Left")
basic_map("n", "<C-j>", "<C-w>j", "Window Down")
basic_map("n", "<C-p>", "<C-w>k", "Window Up")
basic_map("n", "<C-l>", "<C-w>l", "Window Right")

-- Move around in insert mode without leaving
basic_map("i", "<C-h>", "<Left>", "Move Left in Insert")
basic_map("i", "<C-j>", "<Down>", "Move Down in Insert")
basic_map("i", "<C-k>", "<Up>", "Move Up in Insert")
basic_map("i", "<C-l>", "<Right>", "Move Right in Insert")
basic_map("i", "<C-b>", "<ESC>^i", "Move to Beginning of Line in Insert")

-- ## ↕️ Move Lines
basic_map("n", "<leader>j", ":move .+1<CR>==", "Move Line Down")
basic_map("n", "<leader>k", ":move .-2<CR>==", "Move Line Up")
basic_map("v", "<leader>j", ":move '>+1<CR>gv=gv", "Move Selection Down")
basic_map("v", "<leader>k", ":move '<-2<CR>gv=gv", "Move Selection Up")

-- Better Indenting
basic_map("v", "<", "<gv", "Unindent Selection")
basic_map("v", ">", ">gv", "Indent Selection")

-- Make jk a consistent way to exit insert mode
basic_map("i", "jk", "<ESC>", "Exit Insert Mode")

-- Clear search highlights with ESC
basic_map("n", "<ESC>", "<cmd>noh<CR>", "Clear Highlights")

--Search
basic_map("n", "n", "nzzzv", "Next Search Result (Centered)")
basic_map("n", "N", "Nzzzv", "Prev Search Result (Centered)")

-- ## 🖼️ Window Management
basic_map("n", "<leader>-", "<C-W>s", "Split Window Below")
basic_map("n", "<leader>|", "<C-W>v", "Split Window Right")
basic_map("n", "<leader>qw", "<C-W>c", "Close Window")
basic_map("n", "<leader>wo", "<C-W>o", "Close Other Windows")
basic_map("n", "<leader>wt", "<C-W>T", "Move Window to New Tab")
basic_map("n", "<leader>wr", "<C-W>r", "Rotate Windows")
basic_map("n", "<leader>w=", "<C-W>=", "Equalize Window Sizes")

-- Resize window using leader + arrow keys
basic_map("n", "<C-Up>", "<cmd>resize +2<cr>", "Increase Window Height")
basic_map("n", "<C-Down>", "<cmd>resize -2<cr>", "Decrease Window Height")
basic_map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Increase Window Width")
basic_map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease Window Width")

-- Quick window navigation with <leader>w prefix (already mapped above with <C-*> but preserved for flexibility)
basic_map("n", "<leader>wh", "<C-W>h", "Go to Left Window")
basic_map("n", "<leader>wj", "<C-W>j", "Go to Bottom Window")
basic_map("n", "<leader>wk", "<C-W>k", "Go to Top Window")
basic_map("n", "<leader>wl", "<C-W>l", "Go to Right Window")

-- Window movement
basic_map("n", "<leader>wH", "<C-W>H", "Move Window Left")
basic_map("n", "<leader>wJ", "<C-W>J", "Move Window Down")
basic_map("n", "<leader>wK", "<C-W>K", "Move Window Up")
basic_map("n", "<leader>wL", "<C-W>L", "Move Window Right")

-- ## 📂 File and Buffer Management
-- New/Save/Quit
basic_map("n", "<leader>fn", "<cmd>enew<cr>", "New File")
basic_map("n", "<C-s>", "<cmd>w<cr>", "Save File")
basic_map("i", "<C-s>", "<cmd>w<cr>", "Save File")
basic_map("n", "<leader>qa", "<cmd>qa<cr>", "Quit All")

-- Neo Tree
basic_map("n", "<leader>e", "<cmd>Neotree toggle<cr>", "Toggle File Explorer")
basic_map("n", "<leader>br", "<cmd>Neotree buffers reveal float<cr>", "Buffer Explorer")

-- BufferLine
basic_map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", "Next Buffer")
basic_map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", "Previous Buffer")
basic_map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", "Toggle Pin")
basic_map("n", "<leader>bo", "<Cmd>BufferLineGroupClose ungrouped<CR>", "Delete Non-Pinned Buffers")
basic_map("n", "<leader>bc", "<Cmd>BufferLineCloseRight<CR>", "Delete Buffers to the Right")

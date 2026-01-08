local util = require("utils.keymaps")
local basic_map = util.basic_map

-- Toggle Terminal (Normal mode)
basic_map("n", "<leader>t", "<cmd>ToggleTerm<cr>", "Toggle Terminal")

-- Exit ToggleTerm (Terminal mode)
basic_map("t", "<esc><esc>", "<cmd>ToggleTerm<cr>", "Exit ToggleTerm")

-- Open Telescope search for todo comments
basic_map("n", "<leader>I", "<Cmd>TodoTelescope<CR>", "Todo Telescope")

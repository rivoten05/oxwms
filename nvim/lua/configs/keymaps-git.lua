local util = require("utils.keymaps")
local safe_map = util.safe_map -- The safe-calling map function (renamed here for clarity)

local builtin = require("telescope.builtin")

-- Search Git Files
safe_map("n", "<leader>gf", builtin.git_files, "Search Git Files (Telescope)")
-- Note: The utility function's error message will be "Git Files (Telescope) not available"

-- Search Git Branches
safe_map("n", "<leader>gb", builtin.git_branches, "Search Git Branches (Telescope)")

-- Search Git Commits
safe_map("n", "<leader>gc", builtin.git_commits, "Search Git Commits (Telescope)")

-- Search Git Commits for Buffer
safe_map("n", "<leader>gC", builtin.git_bcommits, "Search Git Buffer Commits (Telescope)")

-- File: lua/core/neo-tree/mappings.lua

local M = {
  ["q"] = "close_window",
  ["?"] = "noop",
  ["g?"] = "show_help",
  ["<leader>"] = "noop",
  -- Enhanced navigation
  ["<C-v>"] = "open_vsplit",
  ["<C-x>"] = "open_split",
  ["<C-t>"] = "open_tabnew",
  ["<CR>"] = "open",
  ["<2-LeftMouse>"] = "open",
  -- File operations
  ["<C-c>"] = "copy",
  ["<C-r>"] = "rename",
  ["<C-d>"] = "delete",
  ["<C-n>"] = "add",
  ["<C-p>"] = "paste_from_clipboard",
  -- View controls
  ["R"] = "refresh",
  -- ["H"] = "toggle_hidden",
  -- ["/"] = "fuzzy_finder",
  -- ["#"] = "fuzzy_sorter",
  -- Navigation
  ["<"] = "prev_source",
  [">"] = "next_source",
  ["w"] = "open_with_window_picker",
  -- Git operations
  ["ga"] = "git_add_file",
  ["gr"] = "git_revert_file",
  ["gc"] = "git_commit",
  ["gp"] = "git_push",
  ["gg"] = "git_commit_and_push",
}

return M

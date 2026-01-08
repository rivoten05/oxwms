local M = {}

function M.setup(dashboard)
  dashboard.section.header.val = {

  }

  dashboard.section.buttons.val = {
    dashboard.button("n", "  > New File", "<cmd>enew<CR>"),
    dashboard.button("SPC e", "  > File Explorer", "<cmd>Neotree filesystem reveal left<CR>"),
    dashboard.button("SPC fp", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
    dashboard.button("SPC fg", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
    dashboard.button("u", "󰚰  > Update Plugins", "<cmd>Lazy sync<CR>"),
    dashboard.button("l", "󰒲  > Lazy", "<cmd>Lazy<CR>"),
    dashboard.button("m", "󰠅  > Mason", "<cmd>Mason<CR>"),
    dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
  }

  dashboard.section.header.opts.hl = "AlphaHeader"
  dashboard.section.buttons.opts.hl = "AlphaButtons"
  dashboard.section.footer.opts.hl = "AlphaFooter"

  local colors = {
    blue = "#74c0fc",
    magenta = "#f783ac",
    green = "#51cf66",
  }

  vim.api.nvim_set_hl(0, "AlphaHeader", { fg = colors.blue, bold = true })
  vim.api.nvim_set_hl(0, "AlphaButtons", { fg = colors.magenta })
  vim.api.nvim_set_hl(0, "AlphaFooter", { fg = colors.green, italic = true })

  dashboard.section.footer.val = " Loading plugins..."
end

return M

-- File: lua/core/noice/config.lua

local M = {
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
    opts = { position = { row = 5, col = "50%" } },
    format = {
      cmdline = { pattern = "^:", icon = "", lang = "vim" },
      search_down = { pattern = "^/", icon = " ", lang = "regex" },
      search_up = { pattern = "^%?", icon = " ", lang = "regex" },
      filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
      lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
    },
  },
  routes = {
    {
      view = "notify",
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      opts = { skip = true },
    },
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    hover = {
      silent = true,
    },
  },
  status = {
    command = {
      hl_group = "NoiceStatusLine",
    },
  },
  views = {
    cmdline_popup = { border = { style = "rounded" } },
    popupmenu = { border = { style = "rounded" } },
    notify = { border = { style = "rounded" } },
    lsp_hover = { border = { style = "rounded" } },
    signature_help = { border = { style = "rounded" } },
  },
}

return M

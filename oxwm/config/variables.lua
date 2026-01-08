---@module 'oxwm'

_G.modkey = "Mod1"
_G.terminal = "kitty"

_G.colors = require("themes.light")

_G.tags = { "", "", "" }

_G.bar_font = "JetBrainsMono Nerd Font"

oxwm.set_terminal(terminal)
oxwm.set_modkey(modkey)
oxwm.set_tags(tags)

---@module 'oxwm'

-- Layout symbols
oxwm.set_layout_symbol("tiling", "[T]")
oxwm.set_layout_symbol("normie", "[F]")
oxwm.set_layout_symbol("tabbed", "[=]")

-- Borders
oxwm.border.set_width(1)
oxwm.border.set_focused_color(colors.bg)
oxwm.border.set_unfocused_color(colors.sep)

-- Gaps
oxwm.gaps.set_smart(false)
oxwm.gaps.set_inner(0, 0)
oxwm.gaps.set_outer(0, 0)

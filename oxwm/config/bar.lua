---@module 'oxwm'

local blocks = {
	oxwm.bar.block.static({
		text = " │  ",
		interval = 999999999,
		color = colors.sep,
		underline = false,
	}),
	oxwm.bar.block.ram({
		format = "󰍛 Ram: {used}/{total} GB",
		interval = 5,
		color = colors.light_blue,
		underline = true,
	}),
	oxwm.bar.block.static({
		text = " │  ",
		interval = 999999999,
		color = colors.sep,
		underline = false,
	}),
	oxwm.bar.block.datetime({
		format = "󰸘 {}",
		date_format = "%a, %b %d - %-I:%M %P",
		interval = 1,
		color = colors.cyan,
		underline = true,
	}),
	oxwm.bar.block.static({
		text = " │  ",
		interval = 999999999,
		color = colors.sep,
		underline = false,
	}),
	-- Uncomment to add battery status (useful for laptops)
	oxwm.bar.block.battery({
		format = "Bat: {}%",
		charging = "⚡ Bat: {}%",
		discharging = "- Bat: {}%",
		full = "✓ Bat: {}%",
		interval = 30,
		color = colors.green,
		underline = true,
	}),
}

oxwm.bar.set_font(bar_font)
oxwm.bar.set_blocks(blocks)

oxwm.bar.set_scheme_normal(colors.fg, colors.bg, "#444444")
oxwm.bar.set_scheme_occupied(colors.cyan, colors.bg, colors.cyan)
oxwm.bar.set_scheme_selected(colors.cyan, colors.bg, colors.purple)

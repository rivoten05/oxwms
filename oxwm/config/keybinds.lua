---@module 'oxwm'

-- Launchers
oxwm.key.bind({ modkey }, "Return", oxwm.spawn_terminal())
oxwm.key.bind({ modkey }, "D", oxwm.spawn({ "sh", "-c", "rofi -show drun" }))

-- Screenshots
oxwm.key.bind({ modkey }, "S", oxwm.spawn({ "sh", "-c", "maim -s | xclip -selection clipboard -t image/png" }))

-- Window controls
oxwm.key.bind({ modkey }, "Q", oxwm.client.kill())
oxwm.key.bind({ modkey, "Shift" }, "F", oxwm.client.toggle_fullscreen())
oxwm.key.bind({ modkey, "Shift" }, "Space", oxwm.client.toggle_floating())

-- Layouts
oxwm.key.bind({ modkey }, "C", oxwm.layout.set("tiling"))
oxwm.key.bind({ modkey }, "N", oxwm.layout.cycle())

-- Focus & movement
oxwm.key.bind({ modkey }, "J", oxwm.client.focus_stack(1))
oxwm.key.bind({ modkey }, "K", oxwm.client.focus_stack(-1))
oxwm.key.bind({ modkey, "Shift" }, "J", oxwm.client.move_stack(1))
oxwm.key.bind({ modkey, "Shift" }, "K", oxwm.client.move_stack(-1))

-- WM lifecycle
oxwm.key.bind({ modkey, "Shift" }, "Q", oxwm.quit())
oxwm.key.bind({ modkey, "Shift" }, "R", oxwm.restart())

oxwm.key.bind({ modkey, "Shift" }, "W", oxwm.spawn("sh -c ~/.config/oxwm/scripts/network.sh"))

oxwm.key.bind({ modkey, "Shift" }, "B", oxwm.spawn("sh -c ~/.config/oxwm/scripts/bluetooth.sh"))

oxwm.key.bind({ modkey, "Shift" }, "E", oxwm.spawn("sh -c ~/.config/oxwm/scripts/emoji.sh"))

oxwm.key.bind({ modkey, "Shift" }, "L", oxwm.spawn("sh -c ~/.config/oxwm/scripts/powermenu.sh"))

oxwm.key.bind({ modkey }, "F7", oxwm.spawn({ "brightnessctl", "set", "+5%" }))

oxwm.key.bind({ modkey }, "F6", oxwm.spawn({ "brightnessctl", "set", "5%-" }))

oxwm.key.bind({ modkey }, "F10", oxwm.spawn({ "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+" }))

oxwm.key.bind({ modkey }, "F9", oxwm.spawn({ "wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-" }))

oxwm.key.bind({ modkey }, "F8", oxwm.spawn({ "wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle" }))

---@module 'oxwm'

-- Workspace (tag) navigation
-- Tags are 0-indexed internally

for i = 1, 9 do
	local idx = i - 1
	local key = tostring(i)

	-- View tag
	oxwm.key.bind({ modkey }, key, oxwm.tag.view(idx))

	-- Move focused window to tag
	oxwm.key.bind({ modkey, "Shift" }, key, oxwm.tag.move_to(idx))

	-- Toggle tag visibility (multi-view)
	oxwm.key.bind({ modkey, "Control" }, key, oxwm.tag.toggleview(idx))

	-- Toggle window on multiple tags
	oxwm.key.bind({ modkey, "Control", "Shift" }, key, oxwm.tag.toggletag(idx))
end

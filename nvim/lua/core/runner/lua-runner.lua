local function execute_lua_chunk(chunk)
	local buf_name = "LuaOutput"
	local buf = vim.fn.bufnr(buf_name)

	if buf == -1 then
		buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(buf, buf_name)
		vim.api.nvim_set_option_value("filetype", "lua", { buf = buf })
		vim.keymap.set("n", "q", ":close<CR>", { buffer = buf, silent = true })
	end

	local width, height = math.ceil(vim.o.columns * 0.5), math.ceil(vim.o.lines * 0.5)
	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.ceil((vim.o.lines - height) / 2),
		col = math.ceil((vim.o.columns - width) / 2),
		style = "minimal",
		border = "rounded",
		title = " Lua Runner ",
		title_pos = "center",
	})

	local output = {}
	local old_print = print
	print = function(...)
		local args = {}
		for i = 1, select("#", ...) do
			local v = select(i, ...)
			table.insert(args, type(v) == "table" and vim.inspect(v) or tostring(v))
		end
		local lines = vim.split(table.concat(args, "\t"), "\n", { plain = true })
		for _, l in ipairs(lines) do
			table.insert(output, l)
		end
	end

	local func, err = load(chunk)
	local ok, result
	local start_time = vim.loop.hrtime()

	if func then
		ok, result = pcall(func)
	else
		ok, result = false, err
	end

	local duration = (vim.loop.hrtime() - start_time) / 1e6
	print = old_print

	if ok then
		if result ~= nil then
			table.insert(output, "Result: " .. vim.inspect(result))
		else
			table.insert(output, "✔ Executed successfully")
		end
	else
		table.insert(output, "❌ Error: " .. result)
	end

	table.insert(output, string.format("⏱ Time: %.2fms", duration))
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
end

-- Normal mode: Run whole buffer
local function eval_buffer()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	execute_lua_chunk(table.concat(lines, "\n"))
end

-- Visual mode: Run selection
local function eval_region()
	-- This ensures we get the latest selection marks
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	execute_lua_chunk(text)
end

vim.keymap.set("n", "<leader>rr", eval_buffer, { desc = "Run Lua Buffer" })
vim.keymap.set("v", "<leader>rr", eval_region, { desc = "Run Lua Selection" })

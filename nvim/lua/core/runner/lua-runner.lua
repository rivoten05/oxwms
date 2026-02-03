local M = {}

local function execute_lua_chunk(chunk)
	local buf_name = "LuaOutput"
	local buf = vim.fn.bufnr(buf_name)

	-- 1. Buffer & Window Logic
	if buf == -1 or not vim.api.nvim_buf_is_valid(buf) then
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

	-- 2. Output Handling
	local output = {}
	local old_print = _G.print -- Ensure we capture the global print

	_G.print = function(...)
		local args = { ... }
		local str_args = {}
		for _, v in ipairs(args) do
			table.insert(str_args, type(v) == "table" and vim.inspect(v) or tostring(v))
		end
		local line = table.concat(str_args, "\t")
		for _, l in ipairs(vim.split(line, "\n")) do
			table.insert(output, l)
		end
	end

	-- 3. Execution
	local func, err = load(chunk)
	local ok, result
	local start_time = vim.loop.hrtime()

	if func then
		ok, result = pcall(func)
	else
		ok, result = false, err
	end

	local duration = (vim.loop.hrtime() - start_time) / 1e6
	_G.print = old_print -- Restore print immediately

	-- 4. Finalizing Output
	if ok then
		if result ~= nil then
			table.insert(output, "Result: " .. vim.inspect(result))
		else
			table.insert(output, "✔ Executed successfully")
		end
	else
		table.insert(output, "❌ Error: " .. tostring(result))
	end

	table.insert(output, string.format("⏱ Time: %.2fms", duration))
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
end

function M.eval_buffer()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	execute_lua_chunk(table.concat(lines, "\n"))
end

function M.eval_region()
	-- Clear register v to ensure clean selection
	vim.fn.setreg("v", "")
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	if text ~= "" then
		execute_lua_chunk(text)
	end
end

return M

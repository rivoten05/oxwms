local function execute_dart_chunk(chunk)
	local buf_name = "DartOutput"
	local buf = vim.fn.bufnr(buf_name)

	-- 1. Create/Get Buffer
	if buf == -1 then
		buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(buf, buf_name)
		vim.api.nvim_set_option_value("filetype", "text", { buf = buf })
		vim.keymap.set("n", "q", ":close<CR>", { buffer = buf, silent = true })
	end

	-- 2. Open Window (Floating)
	local width, height = math.ceil(vim.o.columns * 0.6), math.ceil(vim.o.lines * 0.6)
	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.ceil((vim.o.lines - height) / 2),
		col = math.ceil((vim.o.columns - width) / 2),
		style = "minimal",
		border = "rounded",
		title = " Dart Runner ",
		title_pos = "center",
	})

	-- Clear previous content
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Running Dart..." })

	-- 3. Smart Wrap: Check if we need to add a main() function
	local final_code = chunk
	if not chunk:find("void main%s*(%s*)") then
		final_code = "void main() {\n" .. chunk .. "\n}"
	end

	-- Write to temp file
	local tmp_file = vim.fn.tempname() .. ".dart"
	local f = io.open(tmp_file, "w")
	if f then
		f:write(final_code)
		f:close()
	end
	-- 4. Execute using vim.system
	local start_time = vim.loop.hrtime()

	vim.system({ "dart", "run", tmp_file }, { text = true }, function(obj)
		local duration = (vim.loop.hrtime() - start_time) / 1e6

		-- Schedule UI updates back to the main thread
		vim.schedule(function()
			local output = {}
			if obj.code == 0 then
				table.insert(output, "✔ Executed successfully")
				for _, line in ipairs(vim.split(obj.stdout, "\n")) do
					if line ~= "" then
						table.insert(output, line)
					end
				end
			else
				table.insert(output, "❌ Error (Exit code: " .. obj.code .. ")")
				for _, line in ipairs(vim.split(obj.stderr, "\n")) do
					if line ~= "" then
						table.insert(output, line)
					end
				end
			end

			table.insert(output, string.format("⏱ Time: %.2fms", duration))
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)

			-- Cleanup
			os.remove(tmp_file)
		end)
	end)
end

-- Mappings
local function eval_dart_buffer()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	execute_dart_chunk(table.concat(lines, "\n"))
end

local function eval_dart_region()
	vim.cmd('noau normal! "vy"')
	execute_dart_chunk(vim.fn.getreg("v"))
end

vim.keymap.set("n", "<leader>rr", eval_dart_buffer, { desc = "Run Dart Buffer" })
vim.keymap.set("v", "<leader>rr", eval_dart_region, { desc = "Run Dart Selection" })

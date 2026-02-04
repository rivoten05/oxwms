local M = {}

-- Finds the directory containing pubspec.yaml
local function get_dart_project_root()
	local root_file = vim.fs.find({ "pubspec.yaml" }, {
		upward = true,
		path = vim.fn.expand("%:p:h"),
	})[1]

	if root_file then
		return vim.fs.dirname(root_file)
	end
	return nil
end

local function execute_dart_chunk(chunk)
	local buf_name = "DartOutput"
	local buf = vim.fn.bufnr(buf_name)

	-- Buffer & Window Setup
	if buf == -1 then
		buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(buf, buf_name)
		vim.api.nvim_set_option_value("filetype", "dart", { buf = buf })
		vim.keymap.set("n", "q", ":close<CR>", { buffer = buf, silent = true })
	end

	local width, height = math.ceil(vim.o.columns * 0.7), math.ceil(vim.o.lines * 0.7)
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

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "🚀 Initializing Dart VM...", "" })

	local project_root = get_dart_project_root()
	local tmp_file

	if project_root then
		-- Save temp file inside the project root so 'dart run' finds the pubspec
		tmp_file = project_root .. "/.tmp_nvim_runner.dart"
	else
		-- Fallback to system temp if not in a project
		tmp_file = vim.fn.tempname() .. ".dart"
	end

	local final_code = chunk
	if not chunk:find("void main%s*%(") then
		final_code = "import 'package:algo/anagram.dart';\n\nvoid main() {\n" .. chunk .. "\n}"
	end

	-- Write file to disk
	local f = io.open(tmp_file, "w")
	if f then
		f:write(final_code)
		f:close()
	else
		vim.api.nvim_err_writeln("Error: Could not write temporary file at " .. tmp_file)
		return
	end

	local start_time = vim.loop.hrtime()

	-- Execution options
	local opts = {
		text = true,
		cwd = project_root, -- Set working directory to project root
	}

	vim.system({ "dart", "run", tmp_file }, opts, function(obj)
		local duration = (vim.loop.hrtime() - start_time) / 1e6
		vim.schedule(function()
			local output = {}
			if obj.code == 0 then
				table.insert(output, "✔ Success")
				for _, line in ipairs(vim.split(obj.stdout, "\n")) do
					if line ~= "" then
						table.insert(output, "  " .. line)
					end
				end
			else
				table.insert(output, "❌ Error (Exit code: " .. obj.code .. ")")
				for _, line in ipairs(vim.split(obj.stderr, "\n")) do
					if line ~= "" then
						table.insert(output, "  " .. line)
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

function M.eval_buffer()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	execute_dart_chunk(table.concat(lines, "\n"))
end

function M.eval_region()
	-- Copy visual selection to register 'v'
	vim.cmd('noau normal! "vy"')
	execute_dart_chunk(vim.fn.getreg("v"))
end

return M

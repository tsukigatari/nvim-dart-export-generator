local M = {}

function M.get_current_directory()
	local current_directory = vim.fn.getcwd()
	return current_directory
end

function M.get_path_from_user(current_directory)
	local prompt = string.format("enter path: %s", current_directory)
	local generation_path = vim.fn.input(prompt, "", "file")

	return generation_path
end

function M.directory_exists(directory)
	local ok, err, code = os.rename(directory, directory)
	if not ok then
		if code == 13 then
			return true
		end
	end
	return ok, err
end

function M.get_dart_files_in_directory(user_directory)
	local files = {}

	local directory = io.popen("ls " .. user_directory)

	if not directory then
		return files
	end

	for file in directory:lines() do
		if file:match("%.dart$") then
			table.insert(files, file)
		end
	end

	directory:close()

	return files
end

local state = {
	success = 0,
	error = 1,
}

function M.create_export_file(generation_path, data, index_name)
	if index_name == nil then
		index_name = "index.dart"
	elseif not index_name:match("%.dart$") then
		index_name = index_name .. ".dart"
	end

	local _generation_path = generation_path .. "/" .. index_name
	local file = io.open(_generation_path, "w")

	local _data = table.concat(data, "\n")

	if file then
		file:write(_data)

		file:close()

		return state.success
	else
		return state.error
	end
end

return M

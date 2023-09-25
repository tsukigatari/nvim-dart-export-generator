local M = {}

function M.get_project_name_from_pubspec(current_directory)
	local spec_path = current_directory .. "/" .. "pubspec.yaml"
	local file = io.open(spec_path, "r")

	local value = nil

	if file then
		for line in file:lines() do
			if line:find("name:") then
				value = line:match("name: (.*)")
				break
			end
		end
		if value ~= nil then
			return value
		else
			print("name not found")
		end
		file:close()
	else
		print("file not found")
	end
end

function M.clear_cmd()
	vim.cmd("redraw")
end

function M.get_name_from_user()
	local prompt = string.format("enter index name: ")
	local index_name = vim.fn.input(prompt)

	return index_name
end

function M.create_export_array(project_name, files, user_path)
	local array = {}

	for _, file in pairs(files) do
		local r = "export" .. " " .. "'" .. "package:" .. project_name .. "/" .. user_path .. "/" .. file .. "'" .. ";"
		r = M.path_cleaner(r)
		table.insert(array, r)
	end

	return array
end

function M.path_cleaner(path)
	path = path:gsub("//", "/")
	return path
end

return M

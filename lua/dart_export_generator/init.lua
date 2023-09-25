local directory = require("dart_export_generator.directory")
local utils = require("dart_export_generator.utils")
local resp = require("dart_export_generator.resp")

local M = {}
local full_path = nil
local index_name = nil

function M.setup(pattern)
	local current_directory = directory.get_current_directory()
	local project_name = utils.get_project_name_from_pubspec(current_directory)

	local _current_directory = current_directory .. "/lib/"

	local user_path = directory.get_path_from_user(_current_directory)
	if user_path == nil or user_path == "" or user_path == " " or user_path == "/" then
		print(resp.invalid_user_path)
		return
	end

	utils.clear_cmd()

	full_path = _current_directory .. "/" .. user_path
	full_path = utils.path_cleaner(full_path)
	local exists = directory.directory_exists(full_path)
	if not exists then
		print(resp.directory_not_exists)
		return
	end

	if pattern == "custom" then
		index_name = utils.get_name_from_user()
		if index_name == nil or index_name == "" or index_name == " " then
			print(resp.invalid_index_name)
			return
		end

		if not index_name:match("%.dart$") then
			index_name = index_name .. ".dart"
		end

		utils.clear_cmd()

		local c_exists = directory.file_exists(utils.path_cleaner(full_path .. "/" .. index_name))
		if c_exists then
			print(resp.file_already_exists)
			return
		end
	else
		local d_exists = directory.file_exists(utils.path_cleaner(full_path .. "/" .. "index.dart"))
		if d_exists then
			print(resp.file_already_exists)
			return
		end
	end

	utils.clear_cmd()

	local dart_files = directory.get_dart_files_in_directory(full_path)

	local dart_files_array = utils.create_export_array(project_name, dart_files, user_path)

	local state_created = directory.create_export_file(full_path, dart_files_array, index_name)
	if state_created == 0 then
		index_name = nil
		print(resp.success_created)
	else
		print(resp.error)
	end
end

return M

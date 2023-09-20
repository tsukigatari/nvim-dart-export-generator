local directory = require("dart_export_generator.directory")
local utils = require("dart_export_generator.utils")

local M = {}
local full_path = nil

function M.setup()
	local current_directory = directory.get_current_directory()
	local project_name = utils.get_project_name_from_pubspec(current_directory)

	local _current_directory = current_directory .. "/lib/"

	local user_path = directory.get_path_from_user(_current_directory)
	utils.clear_cmd()

	full_path = _current_directory .. "/" .. user_path

	local dart_files = directory.get_dart_files_in_directory(full_path)

	local dart_files_array = utils.create_export_array(project_name, dart_files, user_path)

	local state_created = directory.create_export_file(full_path, dart_files_array)
	if state_created == 0 then
		print("Successfully created")
	else
		print("Error")
	end
end

return M

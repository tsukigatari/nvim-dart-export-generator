local init = require("dart_export_generator.init")

local M = {}

function M.generate_default()
	init.setup(nil)
end

function M.generate_custom()
	init.setup("custom")
end

return M

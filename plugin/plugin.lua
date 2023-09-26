local module = require("dart_export_generator")

vim.api.nvim_create_user_command("dart-export-generator", module.setup(), { nargs = "*" })

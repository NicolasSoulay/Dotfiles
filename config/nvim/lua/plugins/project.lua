return {
	"ahmedkhalf/project.nvim",
	config = function()
		local project = require("project_nvim")

		project.setup({
			detection_methods = { "pattern" },
			patterns = { ".git", "Makefile", "package.json" },
		})
	end,
}

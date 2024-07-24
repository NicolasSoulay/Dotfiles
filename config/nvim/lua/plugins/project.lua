return {
	"ahmedkhalf/project.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope.nvim",
			event = "Bufenter",
			cmd = { "Telescope" },
		},
	},
	config = function()
		local project = require("project_nvim")
		local telescope = require("telescope")

		project.setup({
			detection_methods = { "pattern" },
			patterns = { ".git", "Makefile", "package.json" },
		})

		telescope.load_extension("projects")
	end,
}

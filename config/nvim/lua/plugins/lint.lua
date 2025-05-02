return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			php = { "phpstan" },
		}

		local phpstan = lint.linters.phpstan
		phpstan.args = {
			"analyze",
			"--error-format=json",
			"--no-progress",
			"--level=10",
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}

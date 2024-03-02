local nvim_lint_config = function()
	local lint = require("lint")
	lint.linters_by_ft = {
		python = { "pylint" },
	}

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			lint.try_lint()
		end,
	})

	vim.keymap.set("n", "gl", function()
		lint.try_lint()
	end, { desc = "Run linter on current file" })
end
return {
	"mfussenegger/nvim-lint",
	config = nvim_lint_config,
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
}

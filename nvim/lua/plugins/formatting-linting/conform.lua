local conform_config = function()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			-- Conform will run multiple formatters sequentially
			json = { "prettier" },
			lua = { "stylua" },
			markdown = { "prettier" },
			python = { "isort", "autopep8" },
			yaml = { "prettier" },
		},
	})

	vim.keymap.set({ "n", "v" }, "<leader>gf", function()
		conform.format({
			lsp_fallback = true,
			async = true,
			timeout_ms = 1000,
		})
	end, { desc = "Format file or selected range" })
end

return {
	"stevearc/conform.nvim",
	config = conform_config,
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
}

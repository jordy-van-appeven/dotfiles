local config_function = function()
	-- vim.keymap.set("n", "<leader>D", function() require("trouble").toggle() end)
	require("trouble").setup({ height = 20 })
	vim.keymap.set("n", "<leader>dD", function()
		require("trouble").toggle("workspace_diagnostics")
	end)
	vim.keymap.set("n", "<leader>dd", function()
		require("trouble").toggle("document_diagnostics")
	end)
	vim.keymap.set("n", "<leader>dq", function()
		vim.cmd("cclose")
		require("trouble").toggle("quickfix")
	end)
	vim.keymap.set("n", "<leader>dl", function()
		vim.cmd("lclose")
		require("trouble").toggle("loclist")
	end)
	vim.keymap.set("n", "gR", function()
		require("trouble").toggle("lsp_references")
	end)
end

return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = config_function,
}

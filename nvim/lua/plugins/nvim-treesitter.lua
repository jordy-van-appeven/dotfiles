local nvim_treesitter_config = function()
	require("nvim-dap-repl-highlights").setup()

	local treesitter = require("nvim-treesitter.configs")
	treesitter.setup({
		ensure_installed = {
			"bash",
			"c",
			"cmake",
			"cpp",
			"csv",
			"cuda",
			"dap_repl",
			"dockerfile",
			"json5",
			"jsonc",
			"latex",
			"lua",
			"markdown",
			"python",
			"query",
			"sql",
			"vim",
			"vimdoc",
			"yaml",
		},

		highlight = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>", -- set to `false` to disable one of the mappings
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"LiadOz/nvim-dap-repl-highlights",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = nvim_treesitter_config,
}

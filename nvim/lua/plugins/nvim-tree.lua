return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			actions = {
				open_file = {
					quit_on_open = true,
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				git_ignored = false,
			},
			git = {
				enable = false,
			},
			view = {
				adaptive_size = true,
				centralize_selection = true,
				relativenumber = true,
				signcolumn = "no",
			},
		})
		vim.keymap.set("n", "<M-1>", "<cmd>NvimTreeFindFileToggle<CR>")
        vim.keymap.set("n", "gx", ":silent !xdg-open %:p:h &<CR>", { noremap = true, silent = true })
	end,
}

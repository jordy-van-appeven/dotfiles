return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	config = function()
		require("dressing").setup({
			input = {
				win_options = {
					-- Disable line wrapping
					wrap = false,
					-- Indicator for when text exceeds window
					list = true,
					listchars = "precedes:…,extends:…",
					-- Increase this for more context when text scrolls off the window
					sidescrolloff = 4,
				},
			},
		})
	end,
}

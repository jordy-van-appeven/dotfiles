return {
	name = "g++ thread sanitizer",
	builder = function()
		local file = vim.fn.expand("%:p")
		local program = vim.fn.expand("%:r") .. ".tsan"
		return {
			cmd = { "g++" },
			args = {
				file,
				"-fsanitize=thread",
				"-o" .. program,
			},
			components = {
				{ "on_complete_notify", statuses = { "SUCCESS" } },
				{
					"on_output_quickfix",
					items_only = true,
					open_on_match = false,
					tail = true,
				},
				"default",
			},
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}

return {
	name = "g++ address sanitizer",
	builder = function()
		local file = vim.fn.expand("%:p")
		local program = vim.fn.expand("%:r") .. ".asan"
		return {
			cmd = { "g++" },
			args = {
				file,
				"-fsanitize=address",
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

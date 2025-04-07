return {
	name = "g++ thread sanitizer and run",
	builder = function()
		-- Full path to current file without extention (see :help expand())
		local program = vim.fn.expand("%:r") .. ".tsan"
		return {
			cmd = { program },
			args = {},
			components = {
				{ "dependencies", task_names = { "g++ thread sanitizer" } },
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

return {
	name = "g++ address sanitizer and run",
	builder = function()
		-- Full path to current file without extention (see :help expand())
		local program = vim.fn.expand("%:r") .. ".asan"
		return {
			cmd = { program },
			args = {},
			components = {
				{ "dependencies", task_names = { "g++ address sanitizer" } },
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

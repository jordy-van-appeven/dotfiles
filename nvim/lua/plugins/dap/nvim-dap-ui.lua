local nvim_dap_ui_config = function()
	local dap = require("dap")

	local dapui = require("dapui")
	dapui.setup({
		expand_lines = true,
		force_buffers = true,
		layouts = {
			{
				elements = {
					{
						id = "repl",
						size = 0.60,
					},
					{
						id = "scopes",
						size = 0.40,
					},
					--                {
					-- 	id = "console",
					-- 	size = 0.20,
					-- },
				},
				position = "bottom",
				size = 10,
			},
			{
				elements = {
					{
						id = "breakpoints",
						size = 0.25,
					},
					{
						id = "stacks",
						size = 0.50,
					},
					{
						id = "watches",
						size = 0.25,
					},
				},
				position = "right",
				size = 35,
			},
		},
	})

	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end

	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end

	dap.listeners.before.event_terminated.dapui_config = function()
		-- dapui.close()
	end

	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end

	-- Keymaps
	vim.keymap.set("n", "<leader>de", dapui.eval)
	vim.keymap.set("n", "<leader>df", dapui.float_element)
	vim.keymap.set("n", "<leader>dt", dapui.toggle)
end

return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = nvim_dap_ui_config,
}

local nvim_dap_config = function()
    -- Icons
    vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        -- group = "UserDefLoadOnce",
        desc = "Prevent colorscheme clearing custom DAP icon colors.",
        callback = function()
            vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939' })
            vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef' })
            vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379' })
        end
    })

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text = 'ﳁ', texthl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped' })

    local dap = require('dap')

	-- Keymaps
	local continue = function()
		if vim.fn.filereadable(".vscode/launch.json") then
			-- By default parses file from current working directory at '.vscode/launch.json'
			require("dap.ext.vscode").load_launchjs(nil, { lldb = { "c", "cpp" } })
		end
		dap.continue()
	end

	vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
	vim.keymap.set("n", "<F4>", dap.restart)
	vim.keymap.set("n", "<F5>", continue)
	vim.keymap.set("n", "<F6>", dap.terminate)
	vim.keymap.set("n", "<F10>", dap.step_over)
	vim.keymap.set("n", "<F11>", dap.step_into)
	vim.keymap.set("n", "<F12>", dap.step_out)

	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			-- CHANGE THIS to your path!
			command = "/home/jordy/codelldb-x86_64-linux-1.10.0/extension/adapter/codelldb",
			args = { "--port", "${port}" },

			-- On windows you may have to uncomment this:
			-- detached = false,
		},
	}

    dap.adapters.lldb = {
		type = "executable",
		command = "/usr/bin/lldb-vscode-17", -- adjust as needed, must be absolute path
		name = "lldb",
	}

    -- Python (Make sure to create virtual env at '~/.virtualenvs/debugpy/' and install 'debugpy' package)
    dap.adapters.python = function(cb, config)
		if config.request == "attach" then
			---@diagnostic disable-next-line: undefined-field
			local port = (config.connect or config).port
			---@diagnostic disable-next-line: undefined-field
			local host = (config.connect or config).host or "127.0.0.1"
			cb({
				type = "server",
				port = assert(port, "`connect.port` is required for a python `attach` configuration"),
				host = host,
				options = {
					source_filetype = "python",
				},
			})
		else
			cb({
				type = "executable",
				command = vim.fn.expand("~/.virtualenvs/debugpy/bin/python"),
				args = { "-m", "debugpy.adapter" },
				options = {
					source_filetype = "python",
				},
			})
		end

        -- json decoder with support for JSON5 https://github.com/stevearc/overseer.nvim/blob/master/doc/third_party.md#dap
        require("dap.ext.vscode").json_decode = require("overseer.json").decode

    end
end

return {
    "mfussenegger/nvim-dap",
    config = nvim_dap_config,
    dependencies = {
        "stevearc/overseer.nvim"
    },
}

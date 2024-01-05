return {
    "mfussenegger/nvim-dap",
    config = function()
        -- Keymaps
        vim.keymap.set("n", "<leader>b", "<cmd>DapToggleBreakpoint<CR>")
        vim.keymap.set("n", "<F5>", "<cmd>DapContinue<CR>")
        vim.keymap.set("n", "<F10>", "<cmd>DapStepOver<CR>")
        vim.keymap.set("n", "<F11>", "<cmd>DapStepInto<CR>")
        vim.keymap.set("n", "<F12>", "<cmd>DapStepOut<CR>")

        -- Python
        -- Make sure to create virtual env at '~/.virtualenvs/debugpy/' and install 'debugpy' package
        local dap = require('dap')
        dap.adapters.python = function(cb, config)
            if config.request == 'attach' then
                ---@diagnostic disable-next-line: undefined-field
                local port = (config.connect or config).port
                ---@diagnostic disable-next-line: undefined-field
                local host = (config.connect or config).host or '127.0.0.1'
                cb({
                    type = 'server',
                    port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                    host = host,
                    options = {
                        source_filetype = 'python',
                    },
                })
            else
                cb({
                    type = 'executable',
                    command = vim.fn.expand('~/.virtualenvs/debugpy/bin/python'),
                    args = { '-m', 'debugpy.adapter' },
                    options = {
                        source_filetype = 'python',
                    },
                })
            end
        end
    end
}

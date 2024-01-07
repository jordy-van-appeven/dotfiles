local nvim_dap_config = function()

    -- Keymaps
    vim.keymap.set("n", "<leader>b", "<cmd>DapToggleBreakpoint<CR>")
    vim.keymap.set("n", "<F5>", "<cmd>DapContinue<CR>")
    vim.keymap.set("n", "<F10>", "<cmd>DapStepOver<CR>")
    vim.keymap.set("n", "<F11>", "<cmd>DapStepInto<CR>")
    vim.keymap.set("n", "<F12>", "<cmd>DapStepOut<CR>")

    local dap = require('dap')

    -- C/C++ (Make sure to install 'codelldb')
    -- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)#installation
    dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
            -- CHANGE THIS to your path!
            command = '/home/jordy/codelldb-x86_64-linux-1.10.0/extension/adapter/codelldb',
            args = { "--port", "${port}" },

            -- On windows you may have to uncomment this:
            -- detached = false,
        }
    }

    -- Python (Make sure to create virtual env at '~/.virtualenvs/debugpy/' and install 'debugpy' package)
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

return {
    "mfussenegger/nvim-dap",
    config = nvim_dap_config,
}

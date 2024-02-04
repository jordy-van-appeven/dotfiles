local nvim_dap_config = function()
    -- Keymaps
    vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>")
    vim.keymap.set("n", "<F5>", "<cmd>DapContinue<CR>")
    vim.keymap.set("n", "<F10>", "<cmd>DapStepOver<CR>")
    vim.keymap.set("n", "<F11>", "<cmd>DapStepInto<CR>")
    vim.keymap.set("n", "<F12>", "<cmd>DapStepOut<CR>")

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

    dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb-dap-18', -- adjust as needed, must be absolute path
        name = 'lldb'
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

    require("dap.ext.vscode").load_launchjs(nil, {
        lldb = { 'c', 'cpp' } })
    end
end

return {
    "mfussenegger/nvim-dap",
    config = nvim_dap_config,
}

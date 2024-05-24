local nvim_dap_ui_config = function()
    local dap = require("dap")

    local dapui = require("dapui")
    dapui.setup({
        layouts = { {
            elements = { {
                id = "scopes", size = 0.25
            }, {
                id = "breakpoints", size = 0.25
            }, {
                id = "stacks", size = 0.25
            }, {
                id = "watches", size = 0.25
            } },
            position = "left",
            size = 35
        }, {
            elements = { {
                id = "repl", size = 1.0
            }, },
            position = "bottom",
            size = 10
        } },

    })

    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end

    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end

    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end

    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end

    -- Keymaps
    vim.keymap.set("n", "<leader>dt", dapui.toggle)
end

return {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = nvim_dap_ui_config,
}

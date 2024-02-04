return {
    'stevearc/overseer.nvim',
    opts = {},
    dependencies = { "mfussenegger/nvim-dap", },
    config = function()
        require("overseer").setup({
            actions = {
                -- Disable built-in actions by setting them to 'false'
                ["open tab"] = false,
            },
            -- templates = { "builtin", "user.cpp_build", "user.python_script" },
            templates = { "builtin" },

            task_list = {
                default_detail = 1,
                -- min_width = {40, 0.99},
                min_height = {8, 25},
                direction = "bottom"
            },

            component_aliases = {
                -- Most tasks are initialized with the default components
                default = {
                    { "display_duration", detail_level = 1 },
                    "on_exit_set_status",
                    "on_complete_notify",
                    "on_complete_dispose",
                },
                -- Tasks from tasks.json use these components
                default_vscode = {
                    {"on_output_quickfix",
                    items_only = true,
                    open_on_match = false,
                    tail = true},
                    "default",
                },
            },
        })

        -- json decoder with support for JSON5 https://github.com/stevearc/overseer.nvim/blob/master/doc/third_party.md#dap
        require("dap.ext.vscode").json_decode = require("overseer.json").decode

        -- By default parses file from current working directory at '.vscode/launch.json'
        require("dap.ext.vscode").load_launchjs()

        -- Keymaps
        vim.keymap.set("n", "<M-2>", "<cmd>OverseerRun <CR>")
        vim.keymap.set("n", "<M-3>", "<cmd>OverseerToggle! bottom<CR>")
    end,
}

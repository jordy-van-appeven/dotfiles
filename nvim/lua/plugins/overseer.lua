return {
    'stevearc/overseer.nvim',
    opts = {},
    dependencies = {
        "rcarriga/nvim-notify"
    },
    config = function()
        require("overseer").setup({
            actions = {
                -- Disable built-in actions by setting them to 'false'
                ["ensure"] = false,
                ["open"] = false,
                ["open tab"] = false,
                ["open hsplit"] = false,
                ["open vsplit"] = false,
                ["open output in quickfix"] = false,
            },
			templates = {
				"builtin",
				"user.cpp_build",
				"user.cpp_build_and_run",
				"user.cpp_address_sanitizer",
				"user.cpp_address_sanitizer_and_run",
				"user.cpp_thread_sanitizer",
				"user.cpp_thread_sanitizer_and_run",
				"user.cpp_undefined_sanitizer",
				"user.cpp_undefined_sanitizer_and_run",
			},

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

        -- Miscellaneous 
        vim.notify = require("notify")

        -- Keymaps
        vim.keymap.set("n", "<M-2>", "<cmd>OverseerToggle bottom<CR>")
        vim.keymap.set("n", "<M-3>", "<cmd>OverseerRun<CR>")
    end,
}

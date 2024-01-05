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

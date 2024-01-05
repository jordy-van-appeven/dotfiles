return {
    "mfussenegger/nvim-dap",
    config = function()
        -- Keymaps
        vim.keymap.set("n", "<leader>b", "<cmd>DapToggleBreakpoint<CR>")
        vim.keymap.set("n", "<F5>", "<cmd>DapContinue<CR>")
        vim.keymap.set("n", "<F10>", "<cmd>DapStepOver<CR>")
        vim.keymap.set("n", "<F11>", "<cmd>DapStepInto<CR>")
        vim.keymap.set("n", "<F12>", "<cmd>DapStepOut<CR>")
    end
}

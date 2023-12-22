return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
        vim.keymap.set("n", "<leader>gl", ":Git log --oneline ", { desc = "Git commits log, current or specific branch" })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "git",
            callback = function()
                vim.opt.foldmethod = "syntax"
            end
        })
    end
}

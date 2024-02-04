return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
            filters = {
                git_ignored = false,
            },
            view = {
                adaptive_size = true,
                centralize_selection = true,
            },
        })
        vim.keymap.set("n", "<M-1>", "<cmd>NvimTreeFindFileToggle<CR>")
    end
}

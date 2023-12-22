return {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.5',
    dependencies = {
        "BurntSushi/ripgrep",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                    }
                }
            }
        })

        telescope.load_extension("fzf");

        -- Key mapping
        vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files in current directory" })
        vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files" })
        vim.keymap.set("n", "<leader>fa", "<cmd>Telescope live_grep<CR>", { desc = "Find string in current directory" })
        vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>",
            { desc = "Find word under cursor in current directory" })
    end
}

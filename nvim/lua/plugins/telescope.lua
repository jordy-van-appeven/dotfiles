local nvim_telescope_config = function()
    local telescope = require("telescope")

    telescope.setup({
        defaults = {
            mappings = {
                i = {
                }
            }
        },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("git_grep")

    -- Key mappings

    -- Search filename
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files in current directory" })
    vim.keymap.set("n", "<leader>fF",
        function()
            require("telescope.builtin").find_files({
                hidden = true,
                no_ignore = true
            })
        end, { desc = "Find files in current directory, including hidden- and '.gitignore' files" })
    vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files" })

    -- Search string
    vim.keymap.set("n", "<leader>fa", "<cmd>Telescope live_grep<CR>", { desc = "Find string in current directory" })
    vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>",
        { desc = "Find word under cursor in project through global search" })

    -- Search project
    vim.keymap.set("n", "<leader>fp",
        function()
            require("telescope.builtin").git_files({
                recurse_submodules = true,
            })
        end, { desc = "Find files in git project" })
    vim.keymap.set("n", "<leader>fP", "<cmd>Telescope git_grep live_grep<CR>",
        { desc = "Find string in git project" })

    -- Misc.
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope git_branches<CR>", { desc = "Find git branches" })
    vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find string in help tags" })
    vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Find string in keymaps" })
    vim.keymap.set("n", "<leader>fR", "<cmd>Telescope resume<CR>", { desc = "Resume last search" })
end

return {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.5',
    dependencies = {
        "BurntSushi/ripgrep",
        "davvid/telescope-git-grep.nvim",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = nvim_telescope_config,
}

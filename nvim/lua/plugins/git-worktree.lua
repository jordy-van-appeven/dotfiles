local config_function = function()
    require("telescope").load_extension("git_worktree")
    local worktree = require("git-worktree")
    worktree.setup()
    worktree.on_tree_change(function(operation, metadata)
        if operation == worktree.Operations.Switch then
            if metadata.path == metadata.prev_path then
                return
            end
            -- Close all unmodified buffers
            -- vim.cmd("bufdo if !&modified | bd | endif")
            -- require("lazy").reload({
            --  plugins = { { name = "cmake-tools" } },
            -- })
            -- Using cmd below, as 'Lazy' plugin api is not working
            vim.cmd("Lazy reload cmake-tools.nvim cmake-gtest.nvim")
            vim.cmd("CMakeSelectCwd " .. metadata.path)
            vim.cmd("LspRestart")
        elseif operation == worktree.Operations.Create then
            vim.cmd("!git -C " .. metadata.path .. " submodule update --init --recursive")
        end
    end)
end

return {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = config_function,
    keys = {
        {
            "<leader>fw",
            "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
            desc = "List git worktrees",
        },
        {
            "<leader>fW",
            "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
            desc = "List git worktrees",
        },
    },
}

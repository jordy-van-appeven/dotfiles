local remote_nvim_config = function()
    require("remote-nvim").setup({
        client_callback = function(port)
            local cmd = (
            "tmux new-window 'nvim --server localhost:%s --remote-ui'"):format(port)

            vim.fn.jobstart(cmd, {
                detach = true,
                on_exit = function(job_id, exit_code, event_type)
                    -- This function will be called when the job exits
                    print("Client", job_id, "exited with code", exit_code, "Event type:", event_type)
                end,
            })
        end,
        offline_mode = {
            -- Should offline mode be enabled?
            enabled = true,
            -- Do not connect to GitHub at all. Not even to get release information.
            no_github = true,
            -- What path should be looked at to find locally available releases
            cache_dir = vim.fn.expand("~/.config/nvim/cache"),
        },
    })
end

return {
    "amitds1997/remote-nvim.nvim",
    config = remote_nvim_config,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
        -- This would be an optional dependency eventually
        "nvim-telescope/telescope.nvim",
    },
    version = "*", -- This keeps it pinned to semantic releases
}

return {
    "rmagatti/auto-session",
    dependencies = { "nvim-telescope/telescope.nvim", },
    enabled = false,
    config = function()
        require("auto-session").setup {
            log_level = vim.log.levels.ERROR,
            auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
            auto_session_enable_last_session = false,
            auto_restore_enabled = false,

            -- ⚠️ This will only work if Telescope.nvim is installed
            -- The following are already the default values, no need to provide them if these are already the settings you want.
            require("telescope").load_extension("session-lens"),
            session_lens = {
                -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
                buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
                load_on_setup = true,
                theme_conf = { border = true },
                previewer = false,
            },
        }

        -- Set mapping for searching a session.
        -- ⚠️ This will only work if Telescope.nvim is installed
        vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
            noremap = true,
        })
    end,
}

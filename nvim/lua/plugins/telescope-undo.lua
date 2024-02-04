local telescope_undo_config = function(_, opts)
    -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
    -- configs for us. We won't use data, as everything is in it's own namespace (telescope
    -- defaults, as well as each extension).
    require("telescope").setup(opts)
    require("telescope").load_extension("undo")
end

return {
    "debugloop/telescope-undo.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
    },
    keys = {
        -- lazy style key map
        { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo-tree history" },
    },
    opts = {
        -- don't use `defaults = { }` here, do this in the main telescope spec
        extensions = {
            undo = {
                -- no other extensions here, they can have their own spec too
            },
        },
    },
    config = telescope_undo_config,
}

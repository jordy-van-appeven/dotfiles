return {
    {
        "Exafunction/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({})
        end,
        enabled = false,
        event = "BufEnter",
    },
    {
        "Exafunction/codeium.vim",
        enabled = false,
        event = "BufEnter",
    },
}

return {
    "akinsho/bufferline.nvim",
    dependencies = { "catppuccin/nvim", "nvim-tree/nvim-web-devicons" },
    version = "*",
    enabled = false,
    config = function()
        require("bufferline").setup {
            -- https://github.com/catppuccin/nvim#special-integrations:~:text=bufferline.nvim-,Special,-coc.nvim
            highlights = require("catppuccin.groups.integrations.bufferline").get(),

            options = {
                mode = "tabs",
                separator_style = "slant",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "NvimTree",
                    }
                },
            },
        }
    end
}

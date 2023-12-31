return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    -- https://github.com/catppuccin/nvim#special-integrations:~:text=bufferline.nvim-,Special,-coc.nvim
    after = "catppuccin",
    enabled = false,
    config = function()
        require("bufferline").setup {

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

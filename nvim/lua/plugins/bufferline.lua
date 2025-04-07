local config_function = function()
    require("bufferline").setup {
        -- https://github.com/catppuccin/nvim#special-integrations:~:text=bufferline.nvim-,Special,-coc.nvim
        -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
        options = {
            always_show_bufferline = false,     -- Setting 'showtabline'
            mode = "tabs",
            numbers = "none",
            separator_style = "slant",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "",
                }
            },
        },
    }
end

return {
    "akinsho/bufferline.nvim",
    dependencies = { "catppuccin/nvim", "nvim-tree/nvim-web-devicons" },
    version = "*",
    enabled = true,
    config = config_function,
}

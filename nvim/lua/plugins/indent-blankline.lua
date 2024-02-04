local indent_blankline_config = function()
    require("ibl").setup {
        debounce = 100,
        indent = {
            char = "▏",
        },
        whitespace = {
            remove_blankline_trail = true,
        },
        scope = { enabled = false },
    }
end

return {
    "lukas-reineke/indent-blankline.nvim",
    config = indent_blankline_config,
    main = "ibl",
}

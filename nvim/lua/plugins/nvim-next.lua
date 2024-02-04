local nvim_next_config = function()
    local nvim_next_builtins = require("nvim-next.builtins")
    local next = require("nvim-next")
    next.setup({
        default_mappings = {
            repeat_style = "original",
        },
        items = {
            nvim_next_builtins.f,
            nvim_next_builtins.t
        }
    })

    -- Quickfix list
    local next_quickfix = require("nvim-next.integrations").quickfix()
    vim.keymap.set("n", "[q", next_quickfix.cprevious, { desc = "previous quickfix list item" })
    vim.keymap.set("n", "]q", next_quickfix.cnext, { desc = "next quickfix list item" })
end
return {
    "ghostbuster91/nvim-next",
    config = nvim_next_config,

}

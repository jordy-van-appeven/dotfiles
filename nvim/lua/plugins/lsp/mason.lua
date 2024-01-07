return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

        mason.setup()

        mason_lspconfig.setup({
            ensure_installed = {
                "bashls",
                "cmake",
                "clangd",
                "jsonls",
                "lua_ls",
                "pyright",
            },
            automatic_installation = true,
        })
    end
}

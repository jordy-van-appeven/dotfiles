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
                "cmake@0.1.5",
                "clangd",
                "dockerls",
                "jsonls",
                "lua_ls",
                "pyright",
                "yamlls",
            },
            automatic_installation = true,
        })
    end
}

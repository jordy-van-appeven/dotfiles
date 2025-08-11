return {
    "williamboman/mason.nvim",
    dependencies = {
        {"williamboman/mason-lspconfig.nvim", version="1"},
    },
    config = function()
        local mason = require("mason")
        mason.setup()

        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            ensure_installed = {
                "basedpyright",
                "bashls",
                "cmake@0.1.5",
                "clangd",
                "dockerls",
                "jsonls",
                "lua_ls",
                "yamlls",
            },
            automatic_installation = true,
        })
    end,
	version = "1",
}

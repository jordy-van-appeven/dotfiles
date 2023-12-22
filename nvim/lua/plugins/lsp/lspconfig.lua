return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")

        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local opts = { noremap = true, silent = true }
        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            -- set keybinds
            opts.desc = "Show LSP references"
            vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

            opts.desc = "Go to declaration"
            vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)

            opts.desc = "Show LSP definitions"
            vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

            opts.desc = "Show LSP implementations"
            vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

            opts.desc = "Show LSP type definitions"
            vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

            opts.desc = "Smart rename"
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)

            opts.desc = "Show buffer diagnostics"
            vim.keymap.set("n", "<leader>E", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

            opts.desc = "Show line diagnostics"
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

            opts.desc = "Go to previous diagnostic"
            vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, opts)

            opts.desc = "Go to next diagnostic"
            vim.keymap.set("n", "]e", vim.diagnostic.goto_next, opts)

            opts.desc = "See available code actions"
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

            opts.desc = "Show signature info popup"
            vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, opts)

            opts.desc = "Show documentation for what is under cursor"
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

            vim.keymap.set("n", "gf", function()
                vim.lsp.buf.format { async = true }
            end, opts)

            opts.desc = "Restart LSP"
            vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
        end

        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = { -- custom settings for lua
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })
    end,
}

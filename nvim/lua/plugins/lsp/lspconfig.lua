local config_function = function()
    local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true }
        opts.buffer = bufnr

		-- Set keybinds
		opts.desc = "Show LSP references"
        vim.keymap.set("n", "gr", function()
			require("telescope.builtin").lsp_references({
				show_line = false,
			})
        end, opts)

        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "gD", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "Smart rename"
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)

        -- opts.desc = "Show all diagnostics"
        -- vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics<CR>", opts)
        --
        -- opts.desc = "Show buffer diagnostics"
        -- vim.keymap.set("n", "<leader>d", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        -- Diagnostics
        local next_diagnostic = require("nvim-next.integrations").diagnostic()

        vim.keymap.set("n", "[d",
            next_diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.HINT } }),
            { desc = "previous diagnostic" })

        vim.keymap.set("n", "]d", next_diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.HINT } }),
            { desc = "next diagnostic" })

        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>ga", vim.lsp.buf.code_action, opts)

        opts.desc = "Show signature info popup"
        vim.keymap.set({ "n", "i" }, "<M-Space>", vim.lsp.buf.signature_help, opts)

        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set({ "n" }, "gi", vim.lsp.buf.hover, opts)

        -- Formatting now done by 'conform.lua'
        -- opts.desc = "Format file"
        -- vim.keymap.set({ "n", "v" }, "<leader>gf", function()
        --     vim.lsp.buf.format { async = true }
        -- end, opts)

        opts.desc = "Restart LSP"
        vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
    end

    -- Diagnostics
    vim.diagnostic.config({
        float = {
            border = 'rounded',
            source = 'always',
        },
        severity_sort = true,
        signs = true,
        underline = false,
        update_in_insert = true,
        virtual_text = false,
    })

    -- Change the Diagnostic symbols in the sign column (gutter)
    local sign = function(opts)
        vim.fn.sign_define(opts.name, {
            texthl = opts.name,
            text = opts.text,
            numhl = ''
        })
    end

    sign({ name = 'DiagnosticSignError', text = " " })
    sign({ name = 'DiagnosticSignWarn', text = " " })
    sign({ name = 'DiagnosticSignHint', text = "󰠠 " })
    sign({ name = 'DiagnosticSignInfo', text = " " })

    -- Set borders
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = 'rounded' }
    )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = 'rounded' }
    )

    -- Used to enable autocompletion (assign to every lsp server config)
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Set LSP servers
    local lspconfig = require("lspconfig")

    lspconfig["bashls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })

    lspconfig["clangd"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "c", "cpp", "tpp", "objc", "objcpp", "cuda", "proto" },
        -- Find 'compile_commands.json' within preset build directory
        on_new_config = function(new_config, _)
            local status, cmake = pcall(require, "cmake-tools")
            if status then
                cmake.clangd_on_new_config(new_config)
            end
        end,
    })

    lspconfig["cmake"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })

    lspconfig["dockerls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })

    lspconfig["jsonls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })

    -- Configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {     -- Custom settings for lua
            Lua = {
                -- Make the language server recognize "vim" global
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    -- Make language server aware of runtime files
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.stdpath("config") .. "/lua"] = true,
                    },
                },
            },
        },
    })

    lspconfig["pyright"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            python = {
                analysis = {
                    diagnosticSeverityOverrides = {
                        reportGeneralTypeIssues = "warning",
                    }
                }
            }
        },
    })

    lspconfig["yamlls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "ghostbuster91/nvim-next",
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = config_function,
}

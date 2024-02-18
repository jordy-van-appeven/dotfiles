local nvim_cmp_config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
        completion = {
            completeopt = "menu,menuone,preview,noselect"
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = "buffer" },
            { name = "codeium"},
            { name = "nvim_lsp" },
            { name = "path" },
            { name = "luasnip" },
        }),
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        formatting = {
            fields = { 'abbr', 'menu', 'kind' },
            format = function(entry, item)
                local menu_icon = {
                    buffer = 'Ω',
                    codeium = "",
                    nvim_lsp = 'λ',
                    path = '🖫',
                    luasnip = '⋗',
                }
                -- Source
                item.kind = menu_icon[entry.source.name]
                item.menu = ({
                    buffer = "[Buffer]",
                    codeium = "[Codeium]",
                    nvim_lsp = "[Lsp]",
                    luasnip = "[LuaSnip]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[LaTeX]",
                })[entry.source.name]
                return item
            end,
        },
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' },
            {
                name = 'cmdline',
                option = {
                    ignore_cmds = { 'Man', '!' }
                }
            }
        })
    })
end

return {
    "hrsh7th/nvim-cmp",
    event = {
        "InsertEnter",
        "CmdlineEnter",
    },
    dependencies = {
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip",
    },
    config = nvim_cmp_config,
}

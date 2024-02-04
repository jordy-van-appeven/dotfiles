local gitsigns_config = function()
    require("gitsigns").setup({
        signs                = {
            add          = { text = '│' },
            change       = { text = '│' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        -- Toggle with ':Gitsigns toggle_signs'
        signcolumn           = true,
        _signs_staged_enable = true,
        watch_gitdir         = {
            follow_files = true
        },
        attach_to_untracked  = true,
        sign_priority        = 6,
        update_debounce      = 100,
        status_formatter     = nil,   -- Use default
        max_file_length      = 40000, -- Disable if file is longer than this (in lines)

        on_attach            = function(bufnr)
            local git_signs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            local next_gitsigns = require("nvim-next.integrations").gitsigns(git_signs)

            map('n', ']h', function()
                if vim.wo.diff then return ']h' end
                vim.schedule(function() next_gitsigns.next_hunk() end)
                return '<Ignore>'
            end, { expr = true })

            map('n', '[h', function()
                if vim.wo.diff then return '[h' end
                vim.schedule(function() next_gitsigns.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true })

            -- Actions
            map('n', '<leader>hs', function() git_signs.stage_hunk() end)
            map('n', '<leader>hr', function() git_signs.reset_hunk() end)
            map('v', '<leader>hs', function() git_signs.stage_hunk(vim.fn.line('.'), vim.fn.line('v')) end)
            map('v', '<leader>hr', function() git_signs.reset_hunk(vim.fn.line('.'), vim.fn.line('v')) end)
            map('n', '<leader>hS', function() git_signs.stage_buffer() end)
            map('n', '<leader>hu', function() git_signs.undo_stage_hunk() end)
            map('n', '<leader>hR', function() git_signs.reset_buffer() end)
            map('n', '<leader>hp', function() git_signs.preview_hunk() end)
            map('n', '<leader>hb', function() git_signs.blame_line({ full = true }) end)
            map('n', '<leader>tb', function() git_signs.toggle_current_line_blame() end)
            map('n', '<leader>hd', function() git_signs.diffthis() end)
            map('n', '<leader>hD', function() git_signs.diffthis('~') end)
            map('n', '<leader>td', function() git_signs.toggle_deleted() end)

            -- Text object
            map({ 'o', 'x' }, 'ih', '<cmd><C-U>Gitsigns select_hunk<CR>')
        end
    })
end

return {
    "lewis6991/gitsigns.nvim",
    config = gitsigns_config,
}

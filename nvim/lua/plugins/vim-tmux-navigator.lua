return {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    init = function()
        -- Remove default mappings
        vim.g.tmux_navigator_no_mappings = 1

        vim.g.tmux_navigator_save_on_switch = 1
    end,
    config = function()
        vim.api.nvim_set_keymap('n', '<C-w>l', ':TmuxNavigateRight<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<C-w>j', ':TmuxNavigateDown<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<C-w>h', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<C-w>k', ':TmuxNavigateUp<CR>', { noremap = true, silent = true })
    end
}

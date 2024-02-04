-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

-- Create/get autocommand group
local augroup = vim.api.nvim_create_augrouplocal
-- Create autocommand
local autocmd = vim.api.nvim_create_autocmd

-- General settings
--------------------

-- Don't auto-comment new lines
autocmd('BufEnter', {
    pattern = '',
    command = 'set fo-=c fo-=r fo-=o'
})

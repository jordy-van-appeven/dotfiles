-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Tabs and indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Line wrapping
vim.opt.wrap = false

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Cursor line
vim.opt.cursorline = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- Global status line
vim.opt.laststatus = 3

-- Backspace
vim.opt.backspace = "indent,eol,start"

-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Keep all other default 'foldopen' entries ("block,mark,percent,quickfix,search,tag,undo")
vim.cmd("set foldopen-=hor")

-- Disable 'swapfile'
vim.opt.swapfile = false

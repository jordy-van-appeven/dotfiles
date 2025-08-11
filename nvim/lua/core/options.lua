-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Tabs and indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Minimum number of lines visible above/below cursor
vim.opt.scrolloff = 10

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
vim.opt.cmdheight = 1

-- Global status line
vim.opt.laststatus = 3

-- Backspace
vim.opt.backspace = "indent,eol,start"

-- Clipboard
-- vim.opt.clipboard:append("unnamedplus")

-- Split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Keep all other default 'foldopen' entries ("block,mark,percent,quickfix,search,tag,undo")
vim.cmd("set foldopen-=hor")

-- Keep 'swapfile' outside working directory
vim.opt.swapfile = true
vim.opt.directory = vim.fn.expand("~/.local/state/nvim/swap//")

-- Also backup file before each write
vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand("~/.local/state/nvim/backup//")

-- Write undo-tree to disk
vim.opt.undofile = true

-- Add filetype(s)
vim.filetype.add({
    extension = {
        tpp = "cpp"
    }
})

-- Better readability of vim diff
vim.opt.diffopt:append({
	"iwhite",
	"internal",
	"indent-heuristic",
	"algorithm:patience",
	"linematch:60",
})

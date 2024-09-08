-- general keymapping
vim.g.mapleader = " "

vim.keymap.set("n", "<ESC>", "<cmd>nohl<CR>")

vim.keymap.set("n", "<C-H>", "<cmd>vertical resize +3<CR>")
vim.keymap.set("n", "<C-L>", "<cmd>vertical resize -3<CR>")
vim.keymap.set("n", "<C-J>", "<cmd>resize +3<CR>")
vim.keymap.set("n", "<C-K>", "<cmd>resize -3<CR>")

vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader>tf", "<C-w>s<C-w>T", { desc = "Duplicate current buffer to new tab" })

vim.keymap.set("c", "<M-BS>", "<C-w>", { desc = "Delete 'word'" })
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { desc = "Return to normal mode" })

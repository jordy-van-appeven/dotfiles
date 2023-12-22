-- general keymapping
vim.g.mapleader = " "

vim.keymap.set("n", "<ESC>", ":nohl<CR>")

vim.keymap.set("n", "<C-H>", ":vertical resize +3<CR>")
vim.keymap.set("n", "<C-L>", ":vertical resize -3<CR>")
vim.keymap.set("n", "<C-J>", ":resize +3<CR>")
vim.keymap.set("n", "<C-K>", ":resize -3<CR>")

vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader>tf", "<C-w>T", { desc = "Move current buffer to new tab" })

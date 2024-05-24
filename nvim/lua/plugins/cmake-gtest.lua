return {
    "hfn92/cmake-gtest.nvim",
    config = function()
        local gtest = require("cmake-gtest")

        gtest.setup({ gtest_quickfix_opts = { show = "always", size = 20 } })

        vim.keymap.set("n", "<M-4>", "<cmd>GTestCodeAction<CR>")
    end,
}

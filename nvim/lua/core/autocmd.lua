-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

-- Create/get autocommand group
local augroup = vim.api.nvim_create_augrouplocal
-- Create autocommand
local autocmd = vim.api.nvim_create_autocmd

-- General settings
--------------------

-- Don't auto-comment new lines
autocmd("BufEnter", {
	pattern = "",
	command = "set fo-=c fo-=r fo-=o",
})

-- Automatically add CMakePresets file to CMake project if it does not exist
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local cwd = vim.fn.getcwd()

		local cmakelists_file_path = cwd .. "/CMakeLists.txt"
		local presets_file_path = cwd .. "/CMakePresets.json"

		if vim.fn.filereadable(cmakelists_file_path) == 1 and vim.fn.filereadable(presets_file_path) == 0 then
			vim.fn.system({
				"cp",
				vim.fn.expand("~/dotfiles/nvim/lua/cmake/CMakePresets.base.json"),
				presets_file_path,
			})
			vim.notify("CMakePresets.json added", vim.log.levels.INFO)
		end
	end,
})

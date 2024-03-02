local mason_tool_installer_config = function()
	local mason_tool_installer = require("mason-tool-installer")

	mason_tool_installer.setup({
		ensure_installed = {
			-- Formatters
			"autopep8",
			{ "isort", version = "5.10.1" },
			"prettier",
			"stylua",
			-- Linters
			{ "pylint", version = "3.0.0a4" },
			{ "yamllint", version = "1.28.0" },
		},
	})
end
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = mason_tool_installer_config,
}

local mason_tool_installer_config = function()
	local mason_tool_installer = require("mason-tool-installer")

	mason_tool_installer.setup({
		ensure_installed = {
			"autopep8",
			"isort",
			"prettier",
			{ "stylua", version = "v2.0.2" },
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

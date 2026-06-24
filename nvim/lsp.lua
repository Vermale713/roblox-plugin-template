vim.lsp.config["luau-lsp"] = vim.tbl_deep_extend("force", vim.lsp.config["luau-lsp"], {
	settings = {
		["luau-lsp"] = {
			completion = {
				imports = {
					requireStyle = "alwaysRelative",
				},
			},
		},
	},
})

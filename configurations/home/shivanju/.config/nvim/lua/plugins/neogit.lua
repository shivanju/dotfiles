return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		graph_style = "unicode",
		integrations = {
			diffview = true,
			telescope = true,
		},
	},
}

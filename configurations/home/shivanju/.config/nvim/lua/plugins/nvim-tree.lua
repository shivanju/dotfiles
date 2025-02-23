return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	opts = {
		sort = {
			sorter = "case_sensitive",
		},
		view = {
			side = "right",
			width = 40,
		},
		filters = {
			git_ignored = false,
			dotfiles = false,
		},
		update_focused_file = {
			enable = true,
		},
	},
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<CR>", silent = true, desc = "Open file tree" },
	},
}

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				side = "right",
				width = 30,
			},
			filters = {
				git_ignored = true,
				dotfiles = true,
			},
			update_focused_file = {
				enable = true,
			},
		})

		-- Keymaps
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
	end,
}

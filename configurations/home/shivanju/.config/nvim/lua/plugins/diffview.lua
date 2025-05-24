return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local actions = require("diffview.actions")
		require("diffview").setup({
			enhanced_diff_hl = true,
			view = {
				merge_tool = {
					layout = "diff3_horizontal", -- left, middle, right
					disable_diagnostics = true, -- disable LSP diagnostics in diff views
				},
			},
			keymaps = {
				view = {
					["q"] = actions.close,
				},
				file_panel = {
					["R"] = actions.refresh_files,
					["q"] = actions.close,
				},
			},
		})

		vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<CR>", { silent = true, desc = "Open diffview" })
		vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { silent = true, desc = "Close diffview" })
		vim.keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory %<CR>", { silent = true, desc = "File history" })
		vim.keymap.set("n", "<leader>dH", "<cmd>DiffviewFileHistory<CR>", { silent = true, desc = "Repo history" })
	end,
}

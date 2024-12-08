return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				dynamic_preview_title = true,
				layout_strategy = "center",
				layout_config = {
					anchor = "N",
					width = 0.7,
					preview_cutoff = 1,
				},
				sorting_strategy = "ascending",
				borderchars = {
					prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
					results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
					preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				},
				mappings = {
					i = {
						["<esc>"] = require("telescope.actions").close,
					},
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>o", builtin.buffers, { desc = "find current buffers" })
		vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "find files" })
		vim.keymap.set("n", "<leader>r", builtin.oldfiles, { desc = "find recently opened files" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "search help" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "search current word" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "search by grep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "search diagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "resume search" })
		vim.keymap.set("n", "<leader>sf", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "search fuzzily in current buffer" })
	end,
}
-- vim: ts=2 sts=2 sw=2 et

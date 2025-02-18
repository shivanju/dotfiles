return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
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

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>o", builtin.buffers, { desc = "Find current buffers" })
		vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>r", builtin.oldfiles, { desc = "Find recently opened files" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current word" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by grep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Resume search" })
		vim.keymap.set("n", "<leader>sb", builtin.builtin, { desc = "Search telescope builtins" })
		vim.keymap.set("n", "<leader>sq", builtin.quickfix, { desc = "Search quickfix list" })
		vim.keymap.set("n", "<leader>sf", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "Search fuzzily in current buffer" })
	end,
}

-- vim: ts=2 sts=2 sw=2 et

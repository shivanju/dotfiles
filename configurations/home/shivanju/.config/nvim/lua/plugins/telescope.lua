return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
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

		local nmap = function(l, r, opts)
			vim.keymap.set("n", l, r, opts)
		end
		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")

		nmap("<leader>o", function()
			builtin.buffers({ sort_mru = true, previewer = false })
		end, { desc = "Find buffers" })
		nmap("<leader>r", function()
			builtin.oldfiles({ only_cwd = true })
		end, { desc = "Find recently opened files" })
		nmap("<leader>f", builtin.find_files, { desc = "Find files" })
		nmap("<leader>sh", builtin.help_tags, { desc = "Search help" })
		nmap("<leader>sw", builtin.grep_string, { desc = "Search current word" })
		nmap("<leader>sg", builtin.live_grep, { desc = "Search by grep" })
		nmap("<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })
		nmap("<leader>sr", builtin.resume, { desc = "Resume search" })
		nmap("<leader>sb", builtin.builtin, { desc = "Search telescope builtins" })
		nmap("<leader>qq", builtin.quickfix, { desc = "Search quickfix list" })
		nmap("<leader>qh", builtin.quickfixhistory, { desc = "Search quickfix history" })
		nmap("<leader>sf", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "Search fuzzily in current buffer" })
	end,
}

-- vim: ts=2 sts=2 sw=2 et

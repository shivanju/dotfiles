return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "➤" },
			topdelete = { text = "➤" },
			changedelete = { text = "▎" },
		},
		current_line_blame = true,
		on_attach = function(bufnr)
			local gs = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			map("n", "]c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gs.nav_hunk("next")
				end
			end, { desc = "Jump to next change" })

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end, { desc = "Jump to previous change" })

			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, { expr = true, desc = "Git blame" })

			map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
			map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et

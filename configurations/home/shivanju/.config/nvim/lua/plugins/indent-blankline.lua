return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		local highlight = {
			"RainbowYellow",
			"RainbowRed",
			"RainbowGreen",
			"RainbowOrange",
			"RainbowBlue",
			"RainbowPurple",
			"RainbowAqua",
		}

		local hooks = require("ibl.hooks")
		-- create the highlight groups in the highlight setup hook
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			-- Soft highlights that match Gruvbox Material
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#d4be98" })
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#ea6962" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a9b665" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#d8a657" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#7daea3" })
			vim.api.nvim_set_hl(0, "RainbowPurple", { fg = "#d3869b" })
			vim.api.nvim_set_hl(0, "RainbowAqua", { fg = "#89b482" })
		end)

		require("ibl").setup({
			enabled = true,
			scope = {
				enabled = false,
				show_start = true,
				show_end = true,
				injected_languages = true,
				highlight = highlight,
				priority = 500,
			},
			indent = {
				char = "┊",
				tab_char = "┊",
				highlight = highlight,
				smart_indent_cap = true,
				priority = 1,
			},
			whitespace = {
				highlight = highlight,
				remove_blankline_trail = true,
			},
		})

		vim.keymap.set("n", "<leader>il", "<cmd>IBLToggle<CR>", { desc = "Toggle indent lines" })
		vim.keymap.set("n", "<leader>is", "<cmd>IBLToggleScope<CR>", { desc = "Toggle indent lines scope" })
	end,
}

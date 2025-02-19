return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		local hooks = require("ibl.hooks")
		-- create the highlight groups in the highlight setup hook
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
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

		-- Optional: Custom keymaps
		vim.keymap.set("n", "<leader>il", "<cmd>IBLToggle<CR>", { desc = "Toggle indent lines" })
		vim.keymap.set("n", "<leader>is", "<cmd>IBLToggleScope<CR>", { desc = "Toggle indent lines scope" })
	end,
}

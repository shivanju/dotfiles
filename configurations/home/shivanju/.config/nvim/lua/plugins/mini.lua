return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.surround").setup()
		require("mini.bufremove").setup()
		require("mini.sessions").setup({
			autoread = false,
			file = ".session.vim",
		})

		vim.keymap.set(
			"n",
			"<M-d>",
			require("mini.bufremove").delete,
			{ silent = true, desc = "delete current buffer" }
		)
		vim.keymap.set(
			"n",
			"<leader>gl",
			require("mini.sessions").read,
			{ silent = true, noremap = true, desc = "load session" }
		)

		-- Restore NvimTree state on session load
		vim.api.nvim_create_autocmd({ "BufEnter" }, {
			pattern = "NvimTree*",
			callback = function()
				local api = require("nvim-tree.api")
				local view = require("nvim-tree.view")

				if not view.is_visible() then
					api.tree.open()
				end
			end,
			group = vim.api.nvim_create_augroup("NvimTreeGroup", { clear = true }),
		})
	end,
}
-- vim: ts=2 sts=2 sw=2 et

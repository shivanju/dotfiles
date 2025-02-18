return {
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		lazy = false,
		init = function()
			vim.g.gruvbox_material_background = "medium"
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et

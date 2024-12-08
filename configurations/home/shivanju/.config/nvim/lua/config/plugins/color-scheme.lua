return {
	{
		-- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		-- Use `:Telescope colorscheme` to see what colorschemes are already installed.
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

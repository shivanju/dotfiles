require("lazy").setup({
	require("plugins.colorscheme"),
	"tpope/vim-sleuth", -- Automatically adjusts 'shiftwidth' and 'expandtab'
	require("plugins.auto-pairs"),
	require("plugins.indent-blankline"),
	require("plugins.nvim-tree"),
	require("plugins.diffview"),
	require("plugins.neogit"),
	require("plugins.gitsigns"),
	{ "folke/which-key.nvim", event = "VimEnter", opts = {} },
	require("plugins.telescope"),
	require("plugins.conform"),
	require("plugins.completion"),
	require("plugins.mini"),
	require("plugins.language-server"),
	require("plugins.treesitter"),
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 20
				elseif term.direction == "vertical" then
					return vim.opt.columns * 0.4
				end
			end,
			open_mapping = [[<c-\>]],
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				icons_enabled = true,
				theme = "gruvbox-material",
				component_separators = "|",
				section_separators = "",
				path = 0,
			},
		},
	},
	{
		"folke/lazydev.nvim",
		priority = 999,
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
})

-- vim: ts=2 sts=2 sw=2 et

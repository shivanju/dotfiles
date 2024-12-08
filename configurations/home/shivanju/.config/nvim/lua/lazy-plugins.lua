require("lazy").setup({
	require("config.plugins.colorscheme"),
	"tpope/vim-sleuth",
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"windwp/nvim-autopairs",
		opts = {
			enable_check_bracket_line = false,
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = {
				char = "┊",
				show_start = false,
				show_end = false,
			},
		},
	},
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			view = {
				side = "right",
			},
			filters = {
				git_ignored = false,
			},
		},
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "open file tree" },
		},
	},
	{ "sindrets/diffview.nvim", opts = {} },
	{ "NeogitOrg/neogit", opts = {} },
	require("config.plugins.gitsigns"),
	{ "folke/which-key.nvim", event = "VimEnter", opts = {} },
	require("config.plugins.telescope"),
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_after_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
	require("config.plugins.completion"),
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
	require("config.plugins.mini"),
	require("config.plugins.language-server"),
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "bash", "c", "html", "lua", "markdown", "vim", "vimdoc" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{ "folke/neodev.nvim", priority = 999, opts = {} },
})

-- vim: ts=2 sts=2 sw=2 et

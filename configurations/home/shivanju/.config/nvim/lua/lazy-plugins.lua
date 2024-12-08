require("lazy").setup({
	require("config.plugins.color-scheme"),
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
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "➤" },
				topdelete = { text = "➤" },
				changedelete = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "jump to next change" })
				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, desc = "jump to previous change" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "preview hunk in floating window" })
				map("n", "<leader>hr", gs.reset_hunk, { desc = "reset hunk" })
			end,
		},
	},
	{ "folke/which-key.nvim", event = "VimEnter", opts = {} },
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		config = function()
			require("telescope").setup({
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

			pcall(require("telescope").load_extension, "fzf")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>o", builtin.buffers, { desc = "find current buffers" })
			vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "find files" })
			vim.keymap.set("n", "<leader>r", builtin.oldfiles, { desc = "find recently opened files" })
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "search help" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "search current word" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "search by grep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "search diagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "resume search" })
			vim.keymap.set("n", "<leader>sf", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "search fuzzily in current buffer" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspAttachGroup", { clear = true }),
				callback = function(event)
					local nmap = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local builtin = require("telescope.builtin")
					nmap("K", vim.lsp.buf.hover, "hover documentation")
					nmap("<C-k>", vim.lsp.buf.signature_help, "signature documentation")
					nmap("<F2>", vim.lsp.buf.rename, "rename")
					nmap("<leader>ca", vim.lsp.buf.code_action, "code action")
					nmap("gD", vim.lsp.buf.declaration, "goto declaration")
					nmap("gd", builtin.lsp_definitions, "goto definitions")
					nmap("gT", builtin.lsp_type_definitions, "goto type definitions")
					nmap("gI", builtin.lsp_implementations, "goto implementations")
					nmap("gr", builtin.lsp_references, "goto references")

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			local servers = {
				pyright = {},
				ts_ls = {},
				prismals = {},
				clangd = {},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								-- Tells lua_ls where to find all the Lua files that you have loaded
								-- for your neovim configuration.
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
							},
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
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
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets
					-- This step is not supported in many windows environments
					-- Remove the below condition to re-enable on windows
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",

			-- Other completion source
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-1),
					["<C-d>"] = cmp.mapping.scroll_docs(1),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-y>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-k>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-j>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- These are my older mappings for same functionalities as above. I am keeping
					-- them so that I get the same results on accidental presses.
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
				},
				formatting = {
					fields = { "menu", "abbr", "kind" },
					format = function(entry, item)
						local menu_icon = {
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							buffer = "[Buffer]",
							path = "[Path]",
						}
						item.menu = menu_icon[entry.source.name]
						return item
					end,
				},
			})
		end,
	},
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
			vim.keymap.set("n", "<leader>ll", require("mini.sessions").read, { silent = true, noremap = true })

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
	},
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

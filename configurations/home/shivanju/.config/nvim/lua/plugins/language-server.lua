return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },

		-- Automatically installs and enables the configured LSP servers.
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				ensure_installed = { "lua_ls", "gopls", "rust_analyzer", "clangd", "pyright", "ts_ls" },
			},
		},

		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("LspAttachGroup", { clear = true }),
			callback = function(event)
				local nmap = function(l, r, desc)
					vim.keymap.set("n", l, r, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				local builtin = require("telescope.builtin")
				nmap("gd", builtin.lsp_definitions, "Goto definitions")
				nmap("gr", builtin.lsp_references, "Goto references")
				nmap("gT", builtin.lsp_type_definitions, "Goto type definitions")
				nmap("gI", builtin.lsp_implementations, "Goto implementations")
				nmap("gD", vim.lsp.buf.declaration, "Goto declaration")
				nmap("K", vim.lsp.buf.hover, "Hover documentation")
				nmap("<C-k>", vim.lsp.buf.signature_help, "Signature documentation")
				nmap("<leader>lr", vim.lsp.buf.rename, "Rename")
				nmap("<leader>la", vim.lsp.buf.code_action, "Code action")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("LSPHighlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("LspDetachGroup", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = event2.buf })
						end,
					})
				end
			end,
		})
	end,
}
-- vim: ts=2 sts=2 sw=2 et

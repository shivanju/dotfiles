-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostic in floating window" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Send buffer diagnostics to loclist" })

vim.keymap.set("i", "jk", "<Esc>", { silent = true })
vim.keymap.set("i", "kj", "<Esc>", { silent = true })
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>update<CR>", { silent = true, desc = "Save file" })
vim.keymap.set("n", "<M-k>", "<cmd>bn<CR>", { silent = true, desc = "Goto next buffer" })
vim.keymap.set("n", "<M-j>", "<cmd>bp<CR>", { silent = true, desc = "Goto previous buffer" })
vim.keymap.set("n", "<M-a>", "<C-^>", { silent = true, desc = "Goto alternate buffer" })
vim.keymap.set("n", "<M-t>", "gt", { silent = true, desc = "Goto next tab" })
vim.keymap.set("n", "<M-T>", "gT", { silent = true, desc = "Goto previous tab" })

-- Remap for dealing with line wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Basic Autocommands ]]

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("YankHighlightGroup", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Misc ]]
-- Diagnostic config
vim.diagnostic.config({
	virtual_text = {
		severity = vim.diagnostic.severity.ERROR,
	},
	signs = false,
})

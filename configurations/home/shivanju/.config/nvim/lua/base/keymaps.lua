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
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>update<cr>", { desc = "Save file" })
vim.keymap.set("n", "<M-k>", "<cmd>bn<cr>", { desc = "Goto next buffer" })
vim.keymap.set("n", "<M-j>", "<cmd>bp<cr>", { desc = "Goto previous buffer" })
vim.keymap.set("n", "<M-a>", "<C-^>", { silent = true, desc = "Goto alternate buffer" })
vim.keymap.set("n", "<M-t>", "gt", { silent = true, desc = "Goto next tab" })
vim.keymap.set("n", "<M-T>", "gT", { silent = true, desc = "Goto previous tab" })

-- Remap for dealing with line wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Quickfix keymaps
local function safe_cmd(opts)
	local _, err = pcall(vim.api.nvim_cmd, opts, {})
	if err then
		vim.api.nvim_err_writeln(err:sub(#"Vim:" + 1))
	end
end
vim.keymap.set("n", "]q", function()
	safe_cmd({ cmd = "cnext", count = vim.v.count1 })
end, { desc = "Next quickfix item(s)" })
vim.keymap.set("n", "[q", function()
	safe_cmd({ cmd = "cprevious", count = vim.v.count1 })
end, { desc = "Previous quickfix item(s)" })
vim.keymap.set("n", "[Q", function()
	safe_cmd({ cmd = "crewind", count = vim.v.count ~= 0 and vim.v.count or nil })
end, { desc = "First quickfix item" })
vim.keymap.set("n", "]Q", function()
	safe_cmd({ cmd = "clast", count = vim.v.count ~= 0 and vim.v.count or nil })
end, { desc = "Last quickfix item" })
vim.keymap.set("n", "<M-q>", function()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			qf_exists = true
		end
	end
	if qf_exists == true then
		vim.cmd("cclose")
		return
	end
	vim.cmd("copen")
end, { desc = "Toggle quickfix window" })

-- [[ Basic Autocommands ]]

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("YankHighlightGroup", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Quickfix window specific keymaps
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("QuickfixGroup", { clear = true }),
	pattern = "qf",
	callback = function()
		-- Make quickfix window take full width at bottom
		vim.cmd("wincmd J")

		vim.keymap.set("n", "<cr>", "<cr><cmd>cclose<cr>", { buffer = true, desc = "Select and close" })

		-- I don't use these often since Telescope doesn't play well if the qflist
		-- is changed like this.
		vim.keymap.set("n", "]f", function()
			local curr = vim.fn.getqflist({ nr = 0 }).nr
			local last = vim.fn.getqflist({ nr = "$" }).nr
			if curr == last then
				vim.notify("No newer quickfix list")
			else
				vim.cmd("cnewer")
			end
		end, { buffer = true, desc = "Newer quickfix list" })
		vim.keymap.set("n", "[f", function()
			local curr = vim.fn.getqflist({ nr = 0 }).nr
			if curr == 0 or curr == 1 then
				vim.notify("No older quickfix list")
			else
				vim.cmd("colder")
			end
		end, { buffer = true, desc = "Older quickfix list" })

		-- Set a reasonable height
		vim.cmd("resize 10")
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

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Goto previous diagnostic" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Goto next diagnostic" })
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
		vim.notify(err:sub(#"Vim:" + 1), vim.log.levels.ERROR)
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

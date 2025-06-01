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

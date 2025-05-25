return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
					},
					layout = {
						position = "right",
					},
				},
				suggestion = {
					enabled = false,
				},
				copilot_model = "gpt-4.1",
			})

			local nmap = function(l, r, opts)
				vim.keymap.set("n", l, r, opts)
			end

			local panel = require("copilot.panel")

			nmap("<leader>co", panel.toggle, { desc = "Toggle Copilot panel" })
			nmap("<leader>cr", panel.refresh, { desc = "Refresh Copilot panel" })
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		config = function()
			require("CopilotChat").setup({})

			local nmap = function(l, r, opts)
				vim.keymap.set("n", l, r, opts)
			end

			nmap("<leader>cc", "<cmd>CopilotChatToggle<cr>", { silent = true, desc = "Toggle CopilotChat" })
			nmap("<leader>cp", "<cmd>CopilotChatPrompts<cr>", { silent = true, desc = "Select CopilotChat prompts" })
			nmap("<leader>cm", "<cmd>CopilotChatModels<cr>", { silent = true, desc = "Select CopilotChat models" })
		end,
	},
}

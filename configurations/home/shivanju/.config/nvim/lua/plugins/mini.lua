return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.ai").setup({ n_lines = 500 })
    require("mini.surround").setup()
    require('mini.pairs').setup()
    require("mini.bufremove").setup()
    require("mini.sessions").setup({
      autoread = false,
      file = ".session.vim",
      directory = "~/NvimSessions",
      force = { read = false, write = false, delete = false },
    })

    local sessions = require("mini.sessions")

    vim.keymap.set("n", "<leader>gs", function()
      if vim.v.this_session ~= "" then
        sessions.write()
      else
        vim.ui.input({
          prompt = "Enter new session name: ",
        }, function(session_name)
          if session_name and session_name ~= "" then
            sessions.write(session_name)
          end
        end)
      end
    end, { silent = true, noremap = true, desc = "Save session" })

    vim.keymap.set("n", "<leader>gl", sessions.select, { silent = true, noremap = true, desc = "List sessions" })

    vim.keymap.set(
      "n",
      "<M-d>",
      require("mini.bufremove").delete,
      { silent = true, desc = "Delete current buffer" }
    )

    -- Restore NvimTree state on session load
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      group = vim.api.nvim_create_augroup("NvimTreeGroup", { clear = true }),
      pattern = "NvimTree*",
      callback = function()
        local api = require("nvim-tree.api")
        local view = require("nvim-tree.view")

        if not view.is_visible() then
          api.tree.open()
        end
      end,
    })
  end,
}
-- vim: ts=2 sts=2 sw=2 et

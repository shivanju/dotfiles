require("lazy").setup({
  require("plugins.colorscheme"),
  require("plugins.auto-pairs"),
  require("plugins.indent-blankline"),
  require("plugins.nvim-tree"),
  require("plugins.diffview"),
  require("plugins.neogit"),
  require("plugins.gitsigns"),
  require("plugins.telescope"),
  require("plugins.conform"),
  require("plugins.completion"),
  require("plugins.mini"),
  require("plugins.treesitter"),
  require("plugins.language-server"),
  require("plugins.llm"),
  { "folke/which-key.nvim", event = "VimEnter", opts = {} },
  "NMAC427/guess-indent.nvim", -- Detect tabstop and shiftwidth automatically
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
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et

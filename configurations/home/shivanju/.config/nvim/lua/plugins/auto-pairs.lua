return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    disable_filetype = { "TelescopePrompt" },
    disable_in_macro = true,
    enable_check_bracket_line = true,
    check_ts = true, -- treesitter integration
  },
}

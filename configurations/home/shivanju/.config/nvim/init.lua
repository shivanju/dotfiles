-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    opts = {
      contrast = 'hard' -- can be "hard", "soft" or empty string
    }
  },
  { 'folke/which-key.nvim',   opts = {} },
  { 'numToStr/Comment.nvim',  opts = {} },
  { 'kylechui/nvim-surround', version = "*", opts = {} },
  {
    'windwp/nvim-autopairs',
    opts = {
      enable_check_bracket_line = false
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'gruvbox',
        component_separators = '|',
        section_separators = '',
        path = 0
      },
    }
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
      show_first_indent_level = true,
      use_treesitter = true,
      show_current_context = false
    }
  },
  {
    "folke/trouble.nvim",
    opts = {
      -- settings without a patched font or icons
      icons = false,
      fold_open = "v",      -- icon used for open folds
      fold_closed = ">",    -- icon used for closed folds
      indent_lines = false, -- add an indent guide below the fold icons
      signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
      },
      use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    }
  },
  { 'j-hui/fidget.nvim',        opts = {} },
  { 'folke/neodev.nvim',        opts = {} },
  { 'kyazdani42/nvim-tree.lua', opts = {} },
  'nvim-treesitter/nvim-treesitter',
  'nvim-tree/nvim-web-devicons',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  { 'L3MON4D3/LuaSnip', version = 'v1.*', opts = {} },
  'saadparwaiz1/cmp_luasnip',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
})

-- set colorscheme
vim.cmd.colorscheme 'gruvbox'

-- [[ Setting options ]]
-- See `:help vim.o`
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.o.laststatus = 3                        -- Global statusline
vim.o.cmdheight = 1                         -- Command-line height
vim.o.showmode = false                      -- Do not show current vim mode since it is already shown on statusline
vim.o.clipboard = 'unnamedplus'             -- Allows neovim to access the system clipboard
vim.o.hlsearch = true                       -- Set highlight on search
vim.o.ignorecase = true                     -- Case insensitive search
vim.o.smartcase = true                      -- Case sensitive search if using /C or capital
vim.wo.number = true                        -- Make line numbers default
vim.o.relativenumber = true                 -- Enable relative line numbering
vim.o.cursorline = true                     -- highlight the current line
vim.o.mouse = 'a'                           -- Enable mouse mode
vim.o.smartindent = true                    -- smart indent
vim.o.autoindent = true                     -- auto indent
vim.o.breakindent = true                    -- Enable break indent
vim.o.undofile = true                       -- Save undo history
vim.o.expandtab = true                      -- convert tabs to spaces
vim.o.shiftwidth = 2                        -- the number of spaces inserted for each indentation
vim.o.tabstop = 2                           -- insert 2 spaces for a tab
vim.o.scrolloff = 2                         -- minimum cursor distance from top or bottom of the screen
vim.o.updatetime = 250                      -- Decrease update time
vim.wo.signcolumn = 'yes'                   -- Show signcolumn
vim.o.completeopt = 'menu,menuone,noselect' -- Set completeopt to have a better completion experience
vim.o.backup = false                        -- backup file creation
vim.o.conceallevel = 0                      -- so that `` is visible in markdown files
vim.o.pumheight = 10                        -- pop up menu height
vim.o.splitbelow = true                     -- force all horizontal splits to go below current window
vim.o.splitright = true                     -- force all vertical splits to go to the right of current window
vim.o.swapfile = false                      -- swapfile creation
vim.o.timeoutlen = 500                      -- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.whichwrap = 'b,s,<,>,[,]'             -- allow left, right keys to wrap around lines
vim.o.winbar = '%n %m%F'                    -- Show buffer info on the winbar

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set('i', 'jk', '<Esc>', { silent = true })
vim.keymap.set('i', 'kj', '<Esc>', { silent = true })
vim.keymap.set('i', '<M-h>', '<C-o>h', { silent = true })
vim.keymap.set('i', '<M-l>', '<C-o>a', { silent = true })
vim.keymap.set('i', '<M-a>', '<C-o>^', { silent = true })
vim.keymap.set('i', '<M-e>', '<C-o>$', { silent = true })
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '<M-b>', vim.cmd.bn, { silent = true, desc = 'goto next buffer' })
vim.keymap.set('n', '<M-B>', vim.cmd.bp, { silent = true, desc = 'goto previous buffer' })
vim.keymap.set('n', '<M-d>', vim.cmd.bd, { silent = true, desc = 'delete current buffer' })
vim.keymap.set('n', '<M-a>', '<C-^>', { silent = true, desc = 'goto alternate buffer' })
vim.keymap.set('n', '<M-t>', 'gt', { silent = true, desc = 'goto next tab' })
vim.keymap.set('n', '<M-T>', 'gT', { silent = true, desc = 'goto previous tab' })

-- Remap for dealing with line wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'goto previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'goto next diagnostic' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'show diagnostic in floating window' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'send buffer diagnostics to local list' })

vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeToggle, { desc = 'open nvim-tree' })

-- Global diagnostic config
vim.diagnostic.config({
  virtual_text = false
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      },
      n = {
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      }
    }
  }
})

-- You can pass additional configuration to telescope to change theme, layout, etc.
local theme = require('telescope.themes').get_ivy({
  previewer = false,
})
-- See `:help telescope.builtin`
local ts_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>b', function() ts_builtin.buffers(theme) end,
  { desc = 'find current [b]uffers' })
vim.keymap.set('n', '<leader>f', function() ts_builtin.find_files(theme) end,
  { desc = 'find [f]iles' })
vim.keymap.set('n', '<leader>r', function() ts_builtin.oldfiles(theme) end,
  { desc = 'find [r]ecently opened files' })
vim.keymap.set('n', '<leader>?', ts_builtin.help_tags, { desc = '[?] search help' })
vim.keymap.set('n', '<leader>sw', ts_builtin.grep_string, { desc = '[s]earch current [w]ord' })
vim.keymap.set('n', '<leader>sg', ts_builtin.live_grep, { desc = '[s]earch by [g]rep' })
vim.keymap.set('n', '<leader>sd', ts_builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
vim.keymap.set('n', '<leader>sf', function() ts_builtin.current_buffer_fuzzy_find(theme) end,
  { desc = '[s]earch [f]uzzily in current buffer]' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup({
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'lua', 'python', 'rust', 'typescript', 'json', 'jsonc', 'markdown', 'bash', 'vimdoc' },
  highlight = { enable = true },
})

-- LSP settings.
local lspconfig = require('lspconfig')

-- Set default configuration for all servers
lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  {
    on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('K', vim.lsp.buf.hover, 'hover documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'signature documentation')
      nmap('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
      nmap('gT', vim.lsp.buf.type_definition, '[g]oto [T]ype definition')
      nmap('gI', vim.lsp.buf.implementation, '[g]oto [I]mplementation')
      nmap('<leader>n', vim.lsp.buf.rename, 're[n]ame')
      nmap('<leader>a', vim.lsp.buf.code_action, 'code [a]ction')
      nmap('gr', require('telescope.builtin').lsp_references, '[g]oto [r]eferences')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
          vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
          vim.lsp.buf.formatting()
        end
      end, { desc = 'format current buffer with LSP' })
    end,
    -- nvim-cmp supports additional completion capabilities
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
)

-- Setup mason so it can manage external tooling e.g. LSP servers
require('mason').setup()

require('mason-lspconfig').setup({
  -- Ensure these servers are installed
  ensure_installed = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'lua_ls' },
})

-- Server custom options
local server_custom_opts = {
  lua_ls = function(opts)
    -- Make runtime files discoverable to the server
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')
    opts.settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
          checkThirdParty = false
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false, },
      },
    }
  end,
}

-- Setup servers
local installed_servers = require('mason-lspconfig').get_installed_servers()
for _, server_name in ipairs(installed_servers) do
  local opts = {}
  if server_custom_opts[server_name] ~= nil then
    server_custom_opts[server_name](opts)
  end
  lspconfig[server_name].setup(opts)
end

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-u>'] = cmp.mapping.scroll_docs(-1),
    ['<C-d>'] = cmp.mapping.scroll_docs(1),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'path' },
    { name = 'buffer',                 keyword_length = 4 },
  },
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        buffer = '[Buffer]',
        path = '[Path]',
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

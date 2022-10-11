-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- stylua: ignore start
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'folke/which-key.nvim' -- Display key bindings
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use { 'kylechui/nvim-surround', tag = "*" } -- Add/change/delete surrounding delimiter
  use 'windwp/nvim-autopairs' -- Autopair support
  use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, and navigate code
  use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' } } -- Additional textobjects for treesitter
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'williamboman/mason.nvim' -- Manage external editor tooling i.e. LSP servers
  use 'williamboman/mason-lspconfig.nvim' -- Automatically install language servers to stdpath
  use 'hrsh7th/nvim-cmp' -- Autocompletion engine
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for Neovim's built-in Lsp client
  use 'hrsh7th/cmp-path' -- nvim-cmp source for file paths
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp-signature-help' -- nvim-cmp source for method signature help
  use 'saadparwaiz1/cmp_luasnip' -- luasnip completion source for nvim-cmp
  use { 'L3MON4D3/LuaSnip', tag = 'v1.*' } -- Snippet Engine
  use 'ellisonleao/gruvbox.nvim' -- Colorscheme
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'kyazdani42/nvim-tree.lua' -- File tree explorer
  use 'nvim-lua/plenary.nvim' -- Common lua functions required for other plugins to work
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x' } -- Fuzzy finder over lists
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'akinsho/toggleterm.nvim', tag = '*' } -- Manage neovim's built-in terminal

  if is_bootstrap then
    require('packer').sync()
  end
end)
-- stylua: ignore end

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Set colorscheme
vim.o.termguicolors = true
require('gruvbox').setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd('colorscheme gruvbox')

-- Neovide(https://neovide.dev/) specific configurations
if vim.g.neovide then
  vim.g.gui_font_default_size = 16
  vim.g.gui_font_size = vim.g.gui_font_default_size
  vim.g.gui_font_face = 'Jet Brains Mono'
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_scroll_animation_length = 0.5

  RefreshGuiFont = function()
    vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
  end

  ResizeGuiFont = function(delta)
    vim.g.gui_font_size = vim.g.gui_font_size + delta
    RefreshGuiFont()
  end

  ResetGuiFont = function()
    vim.g.gui_font_size = vim.g.gui_font_default_size
    RefreshGuiFont()
  end

  -- Call function on startup to set default value
  ResetGuiFont()

  -- Keymaps
  local opts = { noremap = true, silent = true }

  vim.keymap.set({ 'n', 'i' }, "<C-+>", function() ResizeGuiFont(1) end, opts)
  vim.keymap.set({ 'n', 'i' }, "<C-->", function() ResizeGuiFont(-1) end, opts)
end

-- [[ Setting options ]]
-- See `:help vim.o`
vim.o.laststatus = 3 -- Global statusline
vim.o.cmdheight = 1 -- Command-line height
vim.o.showmode = false -- Do not show current vim mode since it is already shown on statusline
vim.o.clipboard = 'unnamedplus' -- Allows neovim to access the system clipboard
vim.o.hlsearch = true -- Set highlight on search
vim.o.ignorecase = true -- Case insensitive search
vim.o.smartcase = true -- Case sensitive search if using /C or capital
vim.wo.number = true -- Make line numbers default
vim.o.relativenumber = true -- Enable relative line numbering
vim.o.cursorline = true -- highlight the current line
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.smartindent = true -- smart indent
vim.o.autoindent = true -- auto indent
vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true -- Save undo history
vim.o.expandtab = true -- convert tabs to spaces
vim.o.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.o.tabstop = 2 -- insert 2 spaces for a tab
vim.o.scrolloff = 4 -- minimum cursor distance from top or bottom of the screen
vim.o.updatetime = 250 -- Decrease update time
vim.wo.signcolumn = 'yes' -- Show signcolumn
vim.o.completeopt = 'menu,menuone,noselect' -- Set completeopt to have a better completion experience
vim.o.backup = false -- backup file creation
vim.o.conceallevel = 0 -- so that `` is visible in markdown files
vim.o.fileencoding = "utf-8" -- the encoding written to a file
vim.o.pumheight = 10 -- pop up menu height
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window
vim.o.swapfile = false -- swapfile creation
vim.o.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.whichwrap = 'b,s,<,>,[,]' -- allow left, right keys to wrap around lines
vim.o.winbar = '%n %m%F' -- Show buffer info on the winbar

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set('i', 'jk', '<Esc>', { silent = true })
vim.keymap.set('i', 'kj', '<Esc>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist)

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

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = '|',
    section_separators = '',
    path = 0,
  },
})

-- Enable toggleterm
require('toggleterm').setup({
  open_mapping = [[<c-\>]],
  direction = 'horizontal',
  size = 18,
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true,
  auto_scroll = true
})

-- Enable nvim-tree
require('nvim-tree').setup({
  sort_by = "case_sensitive",
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false,
      }
    }
  }
})
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')

-- Enable Comment.nvim
require('Comment').setup()

-- Enable autopairs
require('nvim-autopairs').setup({
  enable_check_bracket_line = false,
})

-- Enable nvim-surround
require('nvim-surround').setup({})

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup({
  char = '┊',
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  use_treesitter = true,
  show_current_context = false
})

-- Enable which-key
require('which-key').setup()

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup({})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind existing [B]uffers' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = '[F]ind [R]ecently opened files' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sf', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[S]earch [F]uzzily in current buffer]' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'lua', 'python', 'rust', 'typescript', 'json', 'jsonc', 'markdown', 'bash' },

  highlight = { enable = true },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ['<leader>sn'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>sp'] = '@parameter.inner',
      },
    },
  },
}

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

      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gT', vim.lsp.buf.type_definition, '[G]oto [T]ype definition')
      nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_workspace_symbols, '[W]orkspace [S]ymbols')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
          vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
          vim.lsp.buf.formatting()
        end
      end, { desc = 'Format current buffer with LSP' })
    end,

    -- nvim-cmp supports additional completion capabilities
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
)

-- Setup mason so it can manage external tooling e.g. LSP servers
require('mason').setup()

require('mason-lspconfig').setup({
  -- Ensure these servers are installed
  ensure_installed = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'sumneko_lua' },
})

-- Server custom options
local server_custom_opts = {
  sumneko_lua = function(opts)
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
        workspace = { library = vim.api.nvim_get_runtime_file('', true) },
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
    ['<C-b>'] = cmp.mapping.scroll_docs(-1),
    ['<C-f>'] = cmp.mapping.scroll_docs(1),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
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
    { name = 'buffer', keyword_length = 4 },
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

-- File: ~/.config/nvim/init.lua

-- Ensure true color support
vim.opt.termguicolors = true

-- Set line numbers and indentation
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true

-- Plugin manager installation (vim-plug is replaced with 'packer.nvim')
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Plugin configuration
require('packer').startup(function(use)
  -- Plugin manager
  use 'wbthomason/packer.nvim'

  -- Appearance and UI
  use 'morhetz/gruvbox'                  -- Gruvbox theme
  use 'nvim-tree/nvim-web-devicons'      -- File icons
  use 'nvim-lualine/lualine.nvim'        -- Status line

  -- File Explorer
  use 'nvim-tree/nvim-tree.lua'

  -- Treesitter for Better Syntax Highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- LSP and Completion
  use 'neovim/nvim-lspconfig'            -- Core LSP configuration
  use 'williamboman/mason.nvim'          -- LSP/DAP/Formatter installer
  use 'williamboman/mason-lspconfig.nvim'
  use 'hrsh7th/nvim-cmp'                 -- Completion framework
  use 'hrsh7th/cmp-nvim-lsp'             -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer'               -- Buffer source for nvim-cmp
  use 'hrsh7th/cmp-path'                 -- Path source for nvim-cmp
  use 'L3MON4D3/LuaSnip'                 -- Snippet engine
  use 'saadparwaiz1/cmp_luasnip'         -- Snippet source for nvim-cmp

  -- Debugging
  use 'mfussenegger/nvim-dap'

  -- Language-Specific Plugins
  use 'psf/black'                        -- Black formatter for Python
  use 'jose-elias-alvarez/typescript.nvim' -- TypeScript tools
  use 'OmniSharp/omnisharp-vim'          -- C# support

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Gruvbox configuration
vim.cmd [[
  set background=dark
  colorscheme gruvbox
]]

-- Lualine configuration
require('lualine').setup {
  options = { theme = 'gruvbox' },
}

-- Nvim-Tree configuration
require('nvim-tree').setup()

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = { "python", "javascript", "c_sharp", "html", "css", "bash", "json" },
  highlight = { enable = true },
  indent = { enable = true },
}

-- Mason configuration
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "pyright", "tsserver", "omnisharp" },
}

-- LSP setup
local lspconfig = require('lspconfig')
lspconfig.pyright.setup{}        -- Python LSP
lspconfig.tsserver.setup{}       -- JavaScript/TypeScript LSP
lspconfig.omnisharp.setup{}      -- C# LSP

-- Completion setup
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
}

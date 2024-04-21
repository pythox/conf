local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end

return require('packer').startup(function(use)
  --package manager
  use 'wbthomason/packer.nvim'

  --util
  use 'nvim-lua/plenary.nvim'
  use 'inkarkat/vim-ingo-library'

  --git
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  --ui
  use 'Mofiqul/vscode.nvim'
  use 'RRethy/nvim-base16'
  use 'nvim-lualine/lualine.nvim'
  use {'akinsho/bufferline.nvim', tag = "v3.*"}
  use 'nvim-tree/nvim-tree.lua'
  use {
    'junegunn/fzf.vim',
    requires = { 'junegunn/fzf', run = ':call fzf#install()' }
  }
  use 'szw/vim-maximizer'
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use {"shortcuts/no-neck-pain.nvim", tag = "*" }

  --autocomplete
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use { 'L3MON4D3/LuaSnip', tag = 'v<CurrentMajor>.*'}
  use { 'saadparwaiz1/cmp_luasnip' }
  use 'rafamadriz/friendly-snippets'

  --lsp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use {'glepnir/lspsaga.nvim', branch = 'main'}
  use 'nvim-lua/lsp-status.nvim'

  --misc
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'inkarkat/vim-mark'
  use 'rlane/pounce.nvim'
  use 'windwp/nvim-autopairs'
  use 'ojroques/vim-oscyank'
  use 'kshenoy/vim-signature'
  use 'yamatsum/nvim-cursorline'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

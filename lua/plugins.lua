local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- packer plugins
local function plugins(use)
    -- PACKER
    use { 'wbthomason/packer.nvim' }

    -- MISC
    use { 'nvim-lua/plenary.nvim' }                                 -- useful lua functions
    use { 'windwp/nvim-autopairs' }                                 -- auto closing
    use { 'windwp/nvim-ts-autotag', after='nvim-treesitter' }       -- auto tag pairing
    use { 'goolord/alpha-nvim' }                                    -- startup screen
    use { 'echasnovski/mini.animate' }                              -- smooth library 

    -- COLORSCHEME
    use { 'folke/tokyonight.nvim' }
    use { 'lunarvim/darkplus.nvim' }
    use { 'EdenEast/nightfox.nvim' }
    use { 'projekt0n/github-nvim-theme' }

    -- EDITOR
    use { 'numToStr/Comment.nvim' }                                 -- multiline comments
    use { 'PHSix/faster.nvim' }                                     -- accelerated jk
    use { 'nvim-tree/nvim-tree.lua', tag='nightly' }                -- nvim-tree
    use { 'nvim-tree/nvim-web-devicons' }                           -- nvim-web-devicons
    use { 'folke/todo-comments.nvim' }                              -- TODO tree
    use { 'nvim-lualine/lualine.nvim' }                             -- status line
    use { 'akinsho/bufferline.nvim', tag='v3.*' }                   -- bufferline when file edit
    use { 'ahmedkhalf/project.nvim' }                               -- superior project management
    use { 'lukas-reineke/indent-blankline.nvim' }                   -- vertical lines at each indentation level      
    use { 'famiu/bufdelete.nvim' }                                  -- easy buffer deletion
    use { 'akinsho/toggleterm.nvim' }                               -- integrated nvim terminal
    use { 'folke/which-key.nvim' }                                  -- keymap integration
    use { 'kylechui/nvim-surround', tag="*"}                        -- auto surround selection
    use { 'rcarriga/nvim-notify' }                                  -- fancy notification plugin

    -- GIT
    use { 'lewis6991/gitsigns.nvim' }                               -- git change signs on the left

    -- TELESCOPE
    use { 'nvim-telescope/telescope.nvim' }                         -- core
    use { 'nvim-telescope/telescope-fzf-native.nvim', rum='make' }  -- better fzf perf
    use { 'junegunn/fzf' }                                          -- fuzzy finding

    -- TREESITTER
    use { 'nvim-treesitter/nvim-treesitter' }                       -- better syntax highlighting

    -- CMP
    use { "hrsh7th/nvim-cmp" }                                      -- core completion plugin
    use { 'hrsh7th/cmp-buffer' }                                    -- buffer completion support
    use { 'hrsh7th/cmp-path' }                                      -- path completion support
    use { 'hrsh7th/cmp-cmdline' }                                   -- vim cmd completion support
    use { 'hrsh7th/cmp-nvim-lsp' }                                  -- lst completion integration with cmp
    use { 'saadparwaiz1/cmp_luasnip' }                              -- snippet completion support

    -- SNIPPETS
    use { "L3MON4D3/LuaSnip", run="make install_jsregexp" }         -- snippet engine with in-place transformations
    use { "KartavyaSharma/friendly-snippets" }                      -- bunch of snippets

    -- LSP
    use { 'williamboman/mason.nvim' }                               -- plugin manager for lsp/daps
    use { 'williamboman/mason-lspconfig.nvim' }                     -- lsp config integration with mason
    use { 'neovim/nvim-lspconfig' }                                 -- enables lsp
    use { 'mfussenegger/nvim-jdtls' }                               -- java language server
    use { 'folke/trouble.nvim' }                                    -- document diagnostics

    -- LINTING
    use { 'jose-elias-alvarez/null-ls.nvim' }                       -- lsp based code diagnostics and formatting

    -- MARKDOWN
    use { 'iamcco/markdown-preview.nvim' }                          -- browser based markdown preview for nvim

    -- LATEX
    use { 'lervag/vimtex' }                                         -- for working with latex in nvim

    -- NAVIGATION
    use { 'ggandor/leap.nvim' }                                     -- for moving anywhere
    use { 'nanozuki/tabby.nvim' }                                   -- tabline plugin 

    -- DEBUGGING
    use { 'mfussenegger/nvim-dap' }                                 -- debug adapter protocol

    if packer_bootstrap then
        print 'Restart Neovim required after installation!'
        require('packer').sync()
    end
end

-- call packer.startup with plugin function
return packer.startup(plugins)

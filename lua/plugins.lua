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

    -- COLORSCHEME
    use { 'folke/tokyonight.nvim' }
    use { 'lunarvim/darkplus.nvim' }

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
    use { 'karb94/neoscroll.nvim' }                                 -- smooth scrolling
    use { 'famiu/bufdelete.nvim' }                                  -- easy buffer deletion
    use { 'preservim/tagbar' }                                      -- tag bar with file structure

    -- GIT
    use { 'lewis6991/gitsigns.nvim' }                               -- git change signs on the left

    -- TELESCOPE
    use { 'nvim-telescope/telescope.nvim' }                         -- core
    use { 'nvim-telescope/telescope-fzf-native.nvim', rum='make' }  -- better fzf perf
    use { 'junegunn/fzf' }                                          -- fuzzy finding

    -- TREESITTER
    use { 'nvim-treesitter/nvim-treesitter' }

    if packer_bootstrap then
        print 'Restart Neovim required after installation!'
        require('packer').sync()
    end
end

-- call packer.startup with plugin function
return packer.startup(plugins)

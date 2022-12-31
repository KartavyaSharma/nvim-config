local scope = {}

function scope.setup()

    -- packer.nvim configuration
    local conf = {}

    -- Packer bootstrap
    local function packer_init()
        local fn = vim.fn
        local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
        if fn.empty(fn.glob(install_path)) > 0 then
            packer_bootstrap = fn.system {"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
                                          install_path}
            vim.cmd [[packadd packer.nvim]]
        end
        vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    end

    -- Plugins
    local function plugins(use)
        -- Packer
        use {"wbthomason/packer.nvim"}

        -- Startup screen
        use {
            'goolord/alpha-nvim',
            config = function()
                require'alpha'.setup(require'alpha.themes.dashboard'.config)
            end
        }

        -- Colorscheme
        use {'folke/tokyonight.nvim'}
        vim.cmd "colorscheme tokyonight"

        -- Multiline comments
        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        }

        -- Accelerated jk
        use {
            "PHSix/faster.nvim",
            event = {"VimEnter *"},
            config = function()
                vim.api.nvim_set_keymap('n', 'j', '<Plug>(faster_move_j)', {
                    noremap = false,
                    silent = true
                })
                vim.api.nvim_set_keymap('n', 'k', '<Plug>(faster_move_k)', {
                    noremap = false,
                    silent = true
                })
            end
        }

        -- Nvim tree
        use {
            'nvim-tree/nvim-web-devicons',
            config = function()
                require'nvim-web-devicons'.setup {}
                require'nvim-web-devicons'.get_icons()
            end
        }

        use {
            'nvim-tree/nvim-tree.lua',
            tag = 'nightly', -- optional, updated every week. (see issue #1193)
            config = function()
                require('nvim-tree').setup {
                    sort_by = "case_sensitive",
                    view = {
                        adaptive_size = false,
                        mappings = {
                            list = {{
                                key = "u",
                                action = "dir_up"
                            }}
                        }
                    },
                    disable_netrw = true,
                    hijack_netrw = true,
                    open_on_setup = true,
                    ignore_ft_on_setup = {'dashboard'},
                    open_on_tab = false,
                    hijack_cursor = true,
                    update_cwd = true
                }

                -- nvim-tree is also there in modified buffers so this function filter it out
                local modifiedBufs = function(bufs)
                    local t = 0
                    for k, v in pairs(bufs) do
                        if v.name:match("NvimTree_") == nil then
                            t = t + 1
                        end
                    end
                    return t
                end

                vim.api.nvim_create_autocmd("BufEnter", {
                    nested = true,
                    callback = function()
                        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil and
                            modifiedBufs(vim.fn.getbufinfo({
                                bufmodified = 1
                            })) == 0 then
                            vim.cmd "quit"
                        end
                    end
                })
            end
        }

        -- auto closing
        use {
            "windwp/nvim-autopairs",
            config = function()
                require('nvim-autopairs').setup()
            end
        } -- autoclose parens, brackets, quotes, etc...

        -- Treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("config.treesitter").setup()
            end
        }

        use({
            "windwp/nvim-ts-autotag",
            after = "nvim-treesitter"
        }) -- autoclose tags

        -- git integration
        use {
            "lewis6991/gitsigns.nvim",
            config = function()
                require('gitsigns').setup()
            end
        } -- show line modifications on left hand side

        --  vertical lines at each indentation level for code indented with spaces
        use("lukas-reineke/indent-blankline.nvim")

        -- TODO tree
        use({
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim"
        })

        -- statusline
        use {
            "nvim-lualine/lualine.nvim",
            config = function()
                require("lualine").setup()
            end
        }

        -- Telescope
        use {
            "nvim-telescope/telescope.nvim",
            requires = {{'nvim-lua/plenary.nvim'}}
        }

        -- fuzzy finding w/ telescope
        use({
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make"
        }) -- dependency for better sorting performance
        use("junegunn/fzf")

        -- Nvim Navic
        use {
            "SmiteshP/nvim-navic",
            requires = "neovim/nvim-lspconfig",
            config = function()
                local navic = require("nvim-navic")

                require("lspconfig").clangd.setup {
                    on_attach = function(client, bufnr)
                        navic.attach(client, bufnr)
                    end
                }
            end
        }

        if packer_bootstrap then
            print "Restart Neovim required after installation!"
            require("packer").sync()
        end
    end

    packer_init()

    local packer = require "packer"
    packer.init(conf)
    packer.startup(plugins)

end

return scope

local status_ok, mason = pcall(require, 'mason')
if not status_ok then
   return
end

local status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status_ok then
   return
end

local status_cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
   return
end


local mason_config = {

    pip = {
        upgrade_pip = false,
    },

    log_level = vim.log.levels.INFO,

    max_concurrent_installers = 4,

    ui = {
        check_outdated_packages_on_open = true,

        border = "none",

        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },

        keymaps = {
            -- Keymap to expand a package
            toggle_package_expand = "<CR>",
            -- Keymap to install the package under the current cursor position
            install_package = "i",
            -- Keymap to reinstall/update the package under the current cursor position
            update_package = "u",
            -- Keymap to check for new version for the package under the current cursor position
            check_package_version = "c",
            -- Keymap to update all installed packages
            update_all_packages = "U",
            -- Keymap to check which installed packages are outdated
            check_outdated_packages = "C",
            -- Keymap to uninstall a package
            uninstall_package = "X",
            -- Keymap to cancel a package installation
            cancel_installation = "<C-c>",
            -- Keymap to apply language filter
            apply_language_filter = "<C-f>",
        },
    },
}

mason.setup(mason_config)

local masonlsp_config = {
    ensure_installed = {
        -- 'sumneko_lua',
        -- 'bashls',
        -- 'clangd',
        -- 'cssls',
        -- 'eslint',
        -- 'grammarly',
        -- 'jsonls',
        -- 'jdtls',
        -- 'tsserver',
        -- 'pylsp',
    }
}

mason_lspconfig.setup(masonlsp_config)

cmp_lsp.setup({ sources = { name = 'nvim-lsp' } })

local capabilities = cmp_lsp.default_capabilities()

-- Automatic setup using mason-lspconfig
mason_lspconfig.setup_handlers {
    function (server_name)
        require('lspconfig')[server_name].setup { capabilities = capabilities }
    end
}

vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local null_config = {
    debug = false,
    sources = {
        formatting.prettier.with({ extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' } }),
        formatting.stylua,
        formatting.autopep8,
        diagnostics.eslint,
        diagnostics.flake8
    }
}

null_ls.setup(null_config)

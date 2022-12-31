local setup_ok, icons = pcall(require, 'nvim-web-devicons')
if not setup_ok then
    return
end

icons.setup()
icons.get_icons()

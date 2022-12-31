-- NOOB WAY
local scheme = 'tokyonight'

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. scheme)
if not status_ok then
    return
end

-- Doesn't work
-- local status_ok, scheme = pcall(require, 'tokyonight')
-- if not status_ok then
--     return
-- end

-- local setup_config = {
--     style = "storm",
--     transparent = false,
--     sidebars = "dark",
--     floats = "dark",
--     comments = { italic = true },
--     keyboards = { italic = true },
-- }

-- scheme.setup(setup_config)

local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
    return
end

local config = {
    sort_by = 'case_sensitive',
    view = {
        adaptive_size = false,
        mappings = {
            list = {
                {
                    key = 'u',
                    action = 'dir_up'
                },
                {
                    key = 's',
                    action = 'vsplit'
                },
                {
                    key = '<C-v>',
                    action = 'system_open'
                }
            }
        }
    },
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = true,
    ignore_ft_on_setup = { 'dashboard' },
    open_on_tab = false,
    hijack_cursor = true,
    update_cwd = true
}

nvim_tree.setup(config)

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

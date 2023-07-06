-- examples for your init.lua

require("nvim-tree").setup({
    view = {
        adaptive_size = true,
        mappings = {
            custom_only = false,
            list = {
                { key = "l", action = "edit", action_cb = edit_or_open },
                { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
                { key = "h", action = "close_node" },
                { key = "H", action = "collapse_all", action_cb = collapse_all }
            }
        },
    },
    actions = {
        open_file = {
            quit_on_open = true
        }
    }

--   sort_by = "case_sensitive",
--   view = {
--     mappings = {
--       list = {
--         { key = "u", action = "dir_up" },
--       },
--     },
--   },
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = true,
--   },
})
vim.api.nvim_set_keymap('n', '<C-o>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

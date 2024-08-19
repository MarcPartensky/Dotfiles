return {
    "nvim-tree/nvim-tree.lua",

    config = function()
        -- examples for your init.lua
        -- vim.api.nvim_set_keymap('n', '<C-o>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

        local function my_on_attach(bufnr)
            local api = require "nvim-tree.api"

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- custom mappings
            vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
            vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
        end

        require("nvim-tree").setup({
            on_attach = my_on_attach,
            view = {
                adaptive_size = true,
                mappings = {
                    custom_only = false,
                    list = {
                        { key = "l", action = "edit",           action_cb = edit_or_open },
                        { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
                        { key = "h", action = "close_node" },
                        { key = "H", action = "collapse_all",   action_cb = collapse_all }
                    }
                },
            },
            -- actions = {
            --     open_file = {
            --         quit_on_open = true
            --     }
            -- }

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
            --
        })
        vim.api.nvim_create_autocmd("BufEnter", {
            nested = true,
            callback = function()
                if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
                    vim.cmd "quit"
                end
            end
        })
    end
}

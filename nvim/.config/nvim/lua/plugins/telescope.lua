return {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-p>', builtin.find_files, {})
        vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
        vim.keymap.set('n', 'fb', builtin.buffers, {})
        vim.keymap.set('n', 'fh', builtin.help_tags, {})
        require('telescope').setup {
            defaults = {
                -- Telescope configuration options
            },

            -- open telescope instead of empty buffer
            -- vim.api.nvim_create_autocmd("VimEnter", {
            --     callback = function()
            --         if vim.fn.argv(0) == "" then
            --             require("telescope.builtin").find_files()
            --         end
            --     end,
            -- })
        }
    end
}

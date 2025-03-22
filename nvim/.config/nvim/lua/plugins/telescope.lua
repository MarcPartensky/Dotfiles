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
                -- configure to use ripgrep
                vimgrep_arguments = {
                    "rg",
                    "--follow",        -- Follow symbolic links
                    "--hidden",        -- Search for hidden files
                    "--no-ignore",
                    "--no-heading",    -- Don't group matches by each file
                    "--with-filename", -- Print the file path with the matched lines
                    "--line-number",   -- Show line numbers
                    "--column",        -- Show column numbers
                    "--smart-case",    -- Smart case search

                    -- Exclude some patterns from search
                    "--glob=!**/.git/*",
                    "--glob=!**/.idea/*",
                    "--glob=!**/.vscode/*",
                    "--glob=!**/build/*",
                    "--glob=!**/dist/*",
                    "--glob=!**/yarn.lock",
                    "--glob=!**/package-lock.json",
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    -- needed to exclude some files & dirs from general search
                    -- when not included or specified in .gitignore
                    find_command = {
                        "rg",
                        "--files",
                        "--hidden",
                        "--no-ignore",
                        "--glob=!**/.git/*",
                        "--glob=!**/.idea/*",
                        "--glob=!**/.vscode/*",
                        "--glob=!**/build/*",
                        "--glob=!**/dist/*",
                        "--glob=!**/yarn.lock",
                        "--glob=!**/package-lock.json",
                    },
                },
            }

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

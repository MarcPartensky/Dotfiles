return {
    'stevearc/dressing.nvim',
    config = function()
        require('dressing').setup({
            input = {
                -- Options for input UI
            },
            select = {
                backend = { 'telescope', 'fzf_lua', 'fzf', 'builtin' },
                builtin = {
                    border = 'rounded',
                },
            },
        })
    end,
}

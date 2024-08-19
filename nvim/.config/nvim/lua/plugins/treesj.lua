return {
    'Wansmer/treesj',
    keys = {
        { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
        '<space>m',
        '<space>j',
        '<space>s',
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
    config = function()
        require('treesj').setup({ --[[ your config ]] })
    end,
}

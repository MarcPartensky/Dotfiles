-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require('lazy').setup({
    -- Example plugins from your list
    spec = {
        -- import your plugins
        -- { import = "plugins" },
        -- { import = "plugins.tokyonight" },        -- theme
        { import = "plugins.onedark" },           -- theme
        -- { import = "plugins.wal" },               -- theme
        { import = "plugins.treesitter" },        -- syntax coloring
        { import = "plugins.bufferline" },        -- tabs
        { import = "plugins.telescope" },         -- search
        { import = "plugins.lspconfig" },         -- language autocompletion
        { import = "plugins.nvim-cmp" },          -- autocompletion
        { import = "plugins.nvim-web-devicons" }, -- icons
        { import = "plugins.conform" },           -- autoformatter
        { import = "plugins.lualine" },           -- bottom bar
        { import = "plugins.autopairs" },         -- autopairs
        { import = "plugins.dashboard" },         -- dashboard when empty tab
        { import = "plugins.lspsaga" },           -- lsp show function params
        { import = "plugins.scrollbar" },         -- scrollbar
        -- { import = "plugins.nvim-tree" },         -- tab for file explorer
        { import = "plugins.neo-tree" },          -- tab for file explorer
        { import = "plugins.vim-smoothie" },      -- smooth cursor scroll
        { import = "plugins.comment" },           -- comment doesnt work
        { import = "plugins.treesj" },            -- split/join blocks of code
        -- { import = "plugins.noice" },             -- notifications
        { import = "plugins.session-manager" },   -- notifications
        { import = "plugins.dressing" }           -- nice ui for selection
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "onedark" } }, -- doesnt change a thing
    -- automatically check for plugin updates
    checker = { enabled = true },
    -- {
    --     'wbthomason/packer.nvim',
    --     -- This will load packer.nvim
    -- },
    { 'williamboman/mason-lspconfig.nvim' },
    {
        'marcpartensky/markdown-preview.nvim',
        run = 'cd app && yarn install', -- Assuming this is a necessary setup step
        cmd = 'MarkdownPreview',
    },
})

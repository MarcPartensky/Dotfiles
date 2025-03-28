local opt = vim.opt
-- inspired from https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/options.lua

-- general
opt.swapfile = false
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.completeopt = "menuone,noinsert,noselect"
opt.textwidth = 80
opt.formatoptions:append("t") -- enable automatic wrapping based on textwidth

--  neovim ui
opt.number = false
opt.relativenumber = true
opt.smartcase = true
opt.linebreak = true
opt.ignorecase = true
opt.guicursor = ""
-- opt.laststatus = 3
opt.background = "dark"

-- tabs indents
opt.expandtab = true
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4


-- others
opt.hlsearch = false
opt.incsearch = true
opt.wrap = false
opt.nu = true

-- Activer le wrapping pour les fichiers Markdown
vim.cmd([[autocmd FileType markdown setlocal wrap]])

-- Ajuster la largeur de texte et la marge de wrap
vim.cmd([[autocmd FileType markdown setlocal textwidth=80]]) -- Par exemple, 80 caractères par ligne
vim.cmd([[autocmd FileType markdown setlocal wrapmargin=2]]) -- Le texte sera cassé lorsque la marge est atteinte

-- Ajuster la largeur de texte et la marge de wrap
vim.cmd([[autocmd FileType txt setlocal textwidth=80]]) -- Par exemple, 80 caractères par ligne
vim.cmd([[autocmd FileType txt setlocal wrapmargin=2]]) -- Le texte sera cassé lorsque la marge est atteinte

vim.api.nvim_create_augroup("MarkdownSettings", { clear = true })
-- Optionally, do the same for plain text files:
vim.api.nvim_create_autocmd("FileType", {
    group = "MarkdownSettings",
    pattern = "txt",
    callback = function()
        vim.opt_local.textwidth = 80
        vim.opt_local.wrapmargin = 2
    end,
})

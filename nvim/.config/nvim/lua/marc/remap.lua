local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

-- Modes
--   normal_mode       = "n",
--   insert_mode       = "i",
--   visual_mode       = "v",
--   visual_block_mode = "x",
--   term_mode         = "t",
--   command_mode      = "c",

keymap('n', '<C-i>', ":!$PWD/%<CR>", opts)
keymap('n', '<c-n>', ":!alacritty -e nvim '+Telescope find_files'<CR>n", opts)
-- keymap('n', '<C-u>', ":PackerUpdate<cr>", opts)
-- tabs
keymap('n', '<c-t>', ":tabnew<cr>", opts)
-- keymap('n', '<c-w>', ":q<cr>", opts)
keymap('n', '<c-w>', ":q<cr>", opts)
keymap('n', '<tab>', ':BufferLineCycleNext<CR>', opts)
keymap('n', '<s-tab>', ':BufferLineCyclePrev<CR>', opts)
-- keymap('n', '<c-w>', ":BufferClose<cr>", opts)
-- keymap('n', '<tab>', ':BufferNext<CR>', opts)
-- keymap('n', '<s-tab>', ':BufferPrevious<CR>', opts)
-- keymap('n', '<c-1>', ':BufferGoto 1<CR>', opts)
-- keymap('n', '<c-2>', ':BufferGoto 2<CR>', opts)
-- keymap('n', '<c-3>', ':BufferGoto 3<CR>', opts)
-- keymap('n', '<c-4>', ':BufferGoto 4<CR>', opts)
-- keymap('n', '<c-5>', ':BufferGoto 5<CR>', opts)
-- keymap('n', '<c-6>', ':BufferGoto 6<CR>', opts)
-- keymap('n', '<c-7>', ':BufferGoto 7<CR>', opts)
-- keymap('n', '<c-8>', ':BufferGoto 8<CR>', opts)
-- keymap('n', '<c-9>', ':BufferGoto 9<CR>', opts)
-- keymap('n', '<c-0>', ':BufferLast<CR>', opts)
-- tabs samy
-- keymap("n", "<TAB>", ":BufferLineCycleNext<CR>", opts)
-- keymap("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", opts)
-- git
keymap('n', 'gp', ":!gp<cr>", opts)
keymap('n', 'gn', ":!gn ", opts)
keymap('n', 'gt', ":!gt ", opts)
keymap('n', 'gl', ":!gpl<cr>", opts)
keymap('n', 'gr', ":!grsh<cr>", opts)
-- selection
keymap('n', '<c-a>', "ggVG", opts)
-- save
keymap('n', '<c-s>', ":w<cr>", opts)
-- fn
keymap('n', '<f1>', ":PackerSync<cr>", opts)
keymap('n', '<f3>', ":!curl --silent ipconfig.io<cr>", opts)
keymap('n', '<f4>', ":make ", opts)
-- markdown preview
keymap('n', '<mp>', ":MarkdownPreviewToggle", opts)
-- linting
keymap('n', '<c-y>', ":!pylint %<cr>", opts)


-- split
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)


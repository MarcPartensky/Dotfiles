return {
    'akinsho/bufferline.nvim',
    run = ':TSUpdate',
    config = function()
        vim.opt.termguicolors = true
        require("bufferline").setup {
            options = {
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "Nvim Tree",
                        separator = true,
                        text_align = "left"
                    }
                },
                mode = "tabs",
                diagnostics = "nvim_lsp",
                separator_style = { "", "" },
                buffer_close_icon = '',
                modified_icon = '●',
                left_trunc_marker = '',
                right_trunc_marker = '',
                show_close_icon = true,
                show_buffer_close_icons = true,
                color_icons = true,
                show_tab_indicators = true,
                hover = {
                    enable = true,
                }
            }
        }
    end
}

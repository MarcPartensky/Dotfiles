return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- vim.tokyonight_transparent_sidebar = true
        -- vim.tokyonight_transparent = true
        -- vim.opt.background = "dark"
        vim.cmd("colorscheme tokyonight")

        require("tokyonight").setup({
            transparent = true,       -- Enable this to disable setting the background color
            -- Background styles. Can be "dark", "transparent" or "normal"
            sidebars = "transparent", -- style for sidebars, see below
            floats = "transparent",   -- style for floating windows
            -- use the night style
            -- style = "night",
            -- disable italic for functions
            styles = {
                functions = {}
            },
            -- Change the "hint" color to the "orange" color, and make the "error" color bright red
            on_colors = function(colors)
                colors.hint = colors.orange
                colors.error = "#ff0000"
            end
        })
    end
}

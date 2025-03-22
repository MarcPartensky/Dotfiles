-- Ajoutez ce bloc dans un fichier existant de votre dossier lua/plugins/ (ou créez recent-files.lua)
return {
    {
        "smartpde/telescope-recent-files",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("telescope").load_extension("recent_files")
            require("telescope").setup({
                extensions = {
                    recent_files = {
                        stat_limit = 1000, -- Fichiers suivis
                        only_cwd = true,   -- Seulement le répertoire courant
                        disable_devicons = false,
                    }
                }
            })
        end
    }
}

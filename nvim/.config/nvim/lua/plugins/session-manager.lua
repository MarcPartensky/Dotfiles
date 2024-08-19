return {
    'Shatur/neovim-session-manager',
    dependencies = { 'plenary.nvim' }, -- if you install parsers with `nvim-treesitter`
    config = function()
        local Path = require('plenary.path')
        local config = require('session_manager.config')

        -- Configuration du plugin
        require('session_manager').setup({
            sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- Le répertoire où les fichiers de session seront sauvegardés.
            autoload_mode = config.AutoloadMode.LastSession,             -- Définit quoi faire lorsque Neovim est démarré sans arguments. Voir la section "Autoload mode" ci-dessous.
            autosave_last_session = true,                                -- Sauvegarder automatiquement la dernière session à la sortie et lors du changement de session.
            autosave_ignore_not_normal = true,                           -- Le plugin ne sauvegardera pas une session lorsqu'aucun buffer n'est ouvert ou que tous ne sont pas modifiables ou listés.
            autosave_ignore_dirs = {},                                   -- Liste des répertoires où la session ne sera pas autosauvegardée.
            autosave_ignore_filetypes = {                                -- Tous les buffers de ces types de fichiers seront fermés avant que la session ne soit sauvegardée.
                'gitcommit',
                'gitrebase',
            },
            autosave_ignore_buftypes = {},    -- Tous les buffers de ces types de buffers seront fermés avant que la session ne soit sauvegardée.
            autosave_only_in_session = false, -- Toujours autosauvegarder la session. Si vrai, autosauvegarde uniquement après qu'une session soit active.
            max_path_length = 80,             -- Raccourcit le chemin affiché si la longueur dépasse ce seuil. Utiliser 0 pour ne pas raccourcir le chemin du tout.
        })
    end,
}

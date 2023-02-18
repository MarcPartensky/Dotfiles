{ pkgs, ...}: {
    programs.zsh = {
            enable = true;
        }
    targets.genericLinux.enable = true;
}

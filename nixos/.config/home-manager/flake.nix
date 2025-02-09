# {
#   description = "Home Manager configuration of marc";
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

#     home-manager = {
#       url = "github:nix-community/home-manager";
#       inputs.nixpkgs.follows = "nixpkgs";

#       # # no news
#       # lib.homeManagerConfiguration.disableHomeManagerNews = {
#       #   # disabledModules = [ "misc/news.nix" ];
#       #   config = {
#       #     news.display = "silent";
#       #     news.json = lib.mkForce { };
#       #     news.entries = lib.mkForce [ ];
#       #   };
#       # };
#     };

#     hyprland.url = "github:hyprwm/Hyprland";
#   };

#   outputs = { nixpkgs, home-manager, hyprland, ... }:
#     let
#       system = "x86_64-linux";
#       pkgs = nixpkgs.legacyPackages.${system};
#     in {
#       homeConfigurations."marc@tower" = home-manager.lib.homeManagerConfiguration {
#         inherit pkgs;

#         # Specify your home configuration modules here, for example,
#         # the path to your home.nix.
#         modules = [
# 		./home.nix
# 		hyprland.homeManagerModules.default
# 		{wayland.windowManager.hyprland.enable = true;}
# 	];
#     };
#   };
# }

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {nixpkgs, home-manager, hyprland, ...}: {
    homeConfigurations."marc@nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      modules = [
        {
          # wayland.windowManager.hyprland = {
          #   enable = true;
          #   # set the flake package
          #   # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          # };
        }
        # ...
      ];
    };
  };
}

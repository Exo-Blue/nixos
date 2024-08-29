{
    description = "ExoBlue's NixOS configuration";

    # Inputs for building the NixOS system, such as software repositories.
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        disko = {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixcord.url = "github:kaylorben/nixcord";
        nixos-generators = {
            url = "github:nix-community/nixos-generators";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-colors.url = "github:misterio77/nix-colors";
        nix-index-database = {
            url = "github:nix-community/nix-index-database";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        sops-nix = {
            url = "github:Mic92/sops-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        ucodenix = {
            url = "github:e-tho/ucodenix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    # This function is run on `nixos-rebuild switch`, and generates NixOS systems
    # based on the `inputs` attribute set, and any `modules` specified.
    outputs = inputs: inputs.snowfall-lib.mkFlake {
         inherit inputs;

        # Where my source files are located
        src = ./.;

        # A namespace to use for my flake's packages, library, and overlays.
        snowfall.namespace = "exoblue";

        channels-config = {
            # Allow unfree packages
            allowUnfree = true;
        };

        systems = {
            # Host specific options
            hosts = {
                # Desktop
                rover = {};
                # Installation/recovery ISO
                skut = {
                    modules = with inputs; [
                        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
                    ];
                };
            };
            # Modules that get imported to every NixOS system
            modules.nixos = with inputs; [
                disko.nixosModules.disko
                ucodenix.nixosModules.ucodenix
            ];
        };

        homes = {
            # Modules that get imported to every home
            modules = with inputs; [
                nix-colors.homeManagerModules.default
                nixcord.homeManagerModules.nixcord
            ];
        };
    };
}
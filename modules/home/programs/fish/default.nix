{ config, lib, pkgs, ... }:

let
    cfg = config.exoblue.programs.fish;
in
{
    options.exoblue.programs.fish.enable = lib.mkEnableOption "fish";

    config = lib.mkIf cfg.enable {
        programs = {
            fish = {
                enable = true;
                plugins = with pkgs.fishPlugins; [
                    { name = "done"; src = done; }
                    { name = "autopair"; src = autopair; }
                ];
                # Use fish for `nix shell` and `nix develop`
                interactiveShellInit = "${lib.getExe pkgs.nix-your-shell} fish | source";
            };
            # Setting fish as our default shell causes some issues. Instead, automatically launch fish
            # when we start an interactive bash shell, but only if we're not opening one from fish.
            bash = {
                enable = true;
                initExtra = # bash
                ''
                    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]; then
                        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
                        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
                    fi
                '';
            };
        };

        # Environment variables
        home.sessionVariables = {
            # The fish greeting is annoying 😡🤜🐟
            fish_greeting = "";
        };
    };
}

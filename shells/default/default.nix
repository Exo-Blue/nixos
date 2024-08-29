
{
    pkgs,
    mkShell,
    ...
}:

mkShell {
    packages = with pkgs; [
        # Command runner
        just
        # Nix language server
        nil
    ];
}
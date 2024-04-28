{
    lockCommand,
    screenshotCommand,
    layout ? "us",
    xkbVariant ? "altgr-intl",
    xkbOptions ? "nodeadkeys,caps:swapescape",
    defaultSession ? "none+i3",
}:
{
    pkgs,
    ...
}:
{
    environment.systemPackages = with pkgs; [
        betterlockscreen
    ];

    services.xserver = {
        inherit layout xkbVariant xkbOptions;
        enable = true;

        displayManager.defaultSession = defaultSession;
        desktopManager = {
            xterm.enable = false;
                    };
        
        windowManager.i3 = {
            enable = true;
        };
    };
}

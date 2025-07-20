{ config, pkgs, lib , ... }:

{
  home.username = "jack";
  home.homeDirectory = "/home/jack";
  home.stateVersion = "25.05";

  # Shell configuration
  programs.zsh.enable = false;
  programs.bash.enable = true;
  programs.git.enable = true;

  home.file.".bashrc".text = ''
    source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    export PATH=$HOME/.local/bin:$PATH
  '';

  # Use i3 but disable the Nix-managed config
  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };
 
  # Link your custom i3 config
  xdg.configFile."i3/config".source = lib.mkForce /home/jack/Documents/.dotfile/i3/config;
 

  # Add packages
  home.packages = with pkgs; [
    wget
    curl
    vim
    git
    neofetch
    home-manager
    nodejs
    pnpm
    zip
    thefuck
    zoxide
    telegram-desktop
    vscodium
    dmenu
    maim
    xclip
    brightnessctl
    pavucontrol
    picom
    nitrogen
    flameshot
    xss-lock
    i3lock
    i3status
    nemo
    ptyxis
    brave
  ];
}

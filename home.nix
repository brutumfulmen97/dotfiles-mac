{ config, pkgs, ... }:

{
  home.username = "vlatko";
  home.homeDirectory = "/Users/vlatko";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    fzf
    ripgrep
    fd
    jq
    eza
    bat
  ];

  home.file.".zshrc".source =
    ./dotfiles/.zshrc;

  home.file.".config/starship.toml".source =
    ./dotfiles/starship/starship.toml;

  home.file.".config/ghostty/config".source =
    ./dotfiles/ghostty/config;

  home.file.".config/tmux/tmux.conf".source =
    ./dotfiles/tmux.conf;

  home.file.".config/zed".source =
    ./dotfiles/zed;

  home.file.".config/karabiner/karabiner.json" = {
    source = ./dotfiles/karabiner.json;
    force = true;
  };
}

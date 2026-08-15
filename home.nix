{
  config,
  lib,
  pkgs,
  ...
}: {
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

  home.file.".config/ghostty/shaders/cursor_smear.glsl".source = 
    ./dotfiles/ghostty/shaders/cursor_smear.glsl;

  home.file.".config/tmux/tmux.conf".source =
    ./dotfiles/tmux.conf;

  home.file.".config/zed".source =
    ./dotfiles/zed;

  # vim.pack writes its lock file in stdpath('config'), so do not symlink the
  # entire config directory into the read-only Nix store.
  home.file.".config/nvim/init.lua".source =
    ./dotfiles/nvim/init.lua;

  home.file.".config/nvim/lua" = {
    source = ./dotfiles/nvim/lua;
    force = true;
  };

  home.activation.nvimConfigDirectory = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    if [ -L "$HOME/.config/nvim" ]; then
      rm "$HOME/.config/nvim"
    fi
  '';

  home.activation.nvimPackLock = lib.hm.dag.entryAfter ["linkGeneration"] ''
    lock_file="$HOME/.config/nvim/nvim-pack-lock.json"
    if [ ! -e "$lock_file" ]; then
      cp ${./dotfiles/nvim/nvim-pack-lock.json} "$lock_file"
    fi
  '';

  home.file.".config/karabiner/karabiner.json" = {
    source = ./dotfiles/karabiner.json;
    force = true;
  };
}

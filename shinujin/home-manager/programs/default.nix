{ lib, pkgs }:
{
  bash = {
    enable = true;
    bashrcExtra = ''
      function t {
          cd $(mktemp -d /tmp/$1.XXXX)
      }
    '';
    shellAliases = {
      less="less -M";
      qr="qrencode -t ANSI256UTF8 $@";
    };
  };
  btop.enable = true;
  chromium = {
    enable = true;
    dictionaries = with pkgs.hunspellDictsChromium; [
      de_DE
      en_GB
      en_US
    ];
    extensions = [ ];
  };
  direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
  firefox.enable = true;
  ghostty = import ./ghostty.nix;
  git = import ./git.nix { inherit lib; };
  home-manager.enable = true;
  imv.enable = true;
  jq.enable = true;
  mpv.enable = true;
  neovim = import ./neovim { inherit lib pkgs; };
  password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.password-store";
      PASSWORD_STORE_GENERATED_LENGTH = "20";
      PASSWORD_STORE_CHARACTER_SET = "[:alnum:]";
      PASSWORD_STORE_CHARACTER_SET_NO_SYMBOLS = "[:alnum:]";
    };
  };
  ripgrep.enable = true;
  # TODO: Configure starship here
  starship.enable = true;
  taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
  };
  vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      ziglang.vscode-zig
      catppuccin.catppuccin-vsc
    ];
  };
  zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
    };
  };
}

{ lib }:
let
  secrets = import ../../secrets.nix { inherit lib; };
in
{
  enable = true;

  userName = secrets.name;
  userEmail = secrets.email;

  ignores = [
    ".envrc"
    "/.direnv"
  ];

  aliases.lg = "log --graph --all --format='%C(yellow)%h%C(auto)%d %Cblue%s %Creset%C(italic)%an (%ar)'";

  diff-so-fancy = {
    enable = true;
    changeHunkIndicators = false;
    markEmptyLines = false;
    stripLeadingSymbols = false;
  };

  extraConfig = {
    merge = {
      tool = "vimdiff";
      conflictstyle = "diff3";
    };
    core = {
      editor = "nvim";
    };
    push = {
      autoSetupRemote = "true";
    };
    pull = {
      rebase = "false";
    };
    init = {
      defaultBranch = "main";
    };
    color = {
      ui = "auto";
    };
  };
}

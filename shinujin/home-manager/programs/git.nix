{ lib }:
let
  secrets = import ../../secrets.nix { inherit lib; };
in
{
  enable = true;

  userName = secrets.name;
  userEmail = secrets.email;

  ignores = [
    ".direnv"
    ".envrc"
    "Session.vim"
  ];

  aliases.lg = "log --graph --all --format='%C(yellow)%h%C(auto)%d %Cblue%s %Creset%C(italic)%an (%ar)'";

  diff-so-fancy = {
    enable = true;
    changeHunkIndicators = false;
    markEmptyLines = false;
    pagerOpts = [
      "--tabs=4"
      "-RFX"
      "-M"
    ];
    stripLeadingSymbols = false;
  };

  extraConfig = {
    diff = {
      algorithm = "histogram";
    };
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

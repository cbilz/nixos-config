{ lib }:
let
  secrets = import ../../../secrets.nix { inherit lib; };
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
    branch = {
      sort = "committerdate";
    };
    column = {
      ui = "auto";
    };
    commit = {
      verbose = "1";
    };
    core = {
      editor = "nvim";
    };
    diff = {
      algorithm = "histogram";
      colorMoved = "zebra";
      colorMovedWS = "allow-indentation-change";
      mnemonicPrefix = "true";
    };
    init = {
      defaultBranch = "main";
    };
    merge = {
      conflictStyle = "diff3";
    };
    pull = {
      rebase = "true";
    };
    rebase = {
      autoSquash = "true";
      autoStash = "true";
    };
    rerere = {
      enabled = "true";
    };
    tag = {
      sort = "version:refname";
    };
  };
}

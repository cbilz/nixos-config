{ lib }:
{
  enable = true;
  extraConfig = {
    user = {
      name = lib.fileContents ~/.secrets/name;
      email = lib.fileContents ~/.secrets/email;
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
    alias = {
      lg = "log --graph --all --format='%C(yellow)%h%C(auto)%d %Cblue%s %Creset%C(italic)%an (%ar)'";
    };
    init = {
      defaultBranch = "main";
    };
    color = {
      ui = "auto";
    };
  };
}

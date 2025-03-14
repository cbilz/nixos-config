# TODO: Research common ways of managing secrets, e.g. with sops-nix.
{ lib }:
{
  hashedUserPassword_ck = lib.fileContents /root/secrets/ck_login_pass;
  hashedUserPassword_boni = lib.fileContents /root/secrets/boni_login_pass;
  name = lib.fileContents /root/secrets/name;
  email = lib.fileContents /root/secrets/email;
}

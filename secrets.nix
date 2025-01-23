# TODO: Research common ways of managing secrets, e.g. with sops-nix.
{ lib }:
{
  hashedUserPassword = lib.fileContents /root/secrets/ck_login_pass;
  name = lib.fileContents /root/secrets/name;
  email = lib.fileContents /root/secrets/email;
}

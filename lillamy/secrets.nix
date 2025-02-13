# TODO: Research common ways of managing secrets, e.g. with sops-nix.
{ lib }:
{
  hashedUserPassword = lib.fileContents /home/admin/secrets/user_pass;
  hashedAdminPassword = lib.fileContents /home/admin/secrets/admin_pass;
  sshPublicKeyShinujin = lib.fileContents /home/admin/secrets/shinujin.pub;
}

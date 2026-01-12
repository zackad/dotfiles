{ config, ... }:
{
  sops.defaultSopsFile = ./secrets/smb_cred;
  sops.defaultSopsFormat = "binary";
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  sops.secrets."smb_cred" = { };
}

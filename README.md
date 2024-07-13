# NixOS Configuration as flake

```shell
# Clone repository
git clone admin@homeserver:repo/zackad/nixos.git ~/Code/nixos

# Copy and edit samba share credentials
cp smb-secrets.example smb-secrets

# Build nixos from flake
sudo nixos-rebuild switch --flake ~/Code/nixos
```

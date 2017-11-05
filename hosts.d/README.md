## Modular host file

### How to use.

1. Clone/download this repository as zipball.
2. Concatenate all files inside `hosts.d` directory with suffix `.conf` into single file.
```
# Linux user can use `cat` command
cat hosts.d/*.conf > hosts

# Windows user can use `type` command
type hosts.d\*.conf > hosts
```
3. Copy the generated file into `/etc/hosts` for (most)linux user or `C:\Windows\system32\drivers\etc\hosts` for (most)windows user.
> **Note:** you may need superuser/administrator privileges to overwrite hosts file.

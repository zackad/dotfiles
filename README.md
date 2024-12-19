# Home-manager configuration as flakes

```shell
# clone repository
git clone git@github.com:zackad/dotfiles --branch linux-home dotfiles

# navigate to cloned repository
cd dotfiles

# run this command if home-manager hasn't been setup
nix run . -- switch --flake .

# subsequence run can use this command
home-manager switch --flake dotfiles
```

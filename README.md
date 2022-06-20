# vim-springboard

## Setting up:

```
cd $HOME
git init
git remote add origin https://github.com/renzmann/vim-springboard
git pull
git checkout main
```

This will put all the files from this repo in your home directory. You are then
free to `rm -rf .git` to remove the git history and re-initialize to your own
repository as you see fit.

## Installing neovim

After performing the clone above, ensure that `~/.local/bin` is on your `PATH`
variable. If it's not, add this line to your `~/.bashrc`:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

just pass in a neovim version to the `install-nvim` command:

```sh
install-nvim "0.7.0"
```

The installation script for `nvim` is included at `.local/bin/install-nvim`.
It will place the `nvim` executable in `~/.local/bin`, so ensure that
`~/.local/bin/nvim` appears before other installations on your `PATH`.

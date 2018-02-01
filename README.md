# My dotfile setup

## How to use


Clone project anywhere in home directory (I have it set to ~/bin/dotfiles)


Place the following in .bash_profile (source the local .bashrc):
```
[[ -s ~/.bashrc ]] && source ~/.bashrc
```
Place the following in .bashrc (source the public .bashrc)
NOTE: The location of the file will depend on where you cloned the dotfile repo.
```
source ~/bin/dotfiles/bashrc
```

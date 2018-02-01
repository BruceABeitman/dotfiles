. ~/bin/dotfiles/bash/config
. ~/bin/dotfiles/bash/env
. ~/bin/dotfiles/bash/aliases
# anything added to bin is added on class path
[ -d ~/bin/dotfiles/bin ] && export PATH=~/bin/dotfiles/bin:$PATH

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# Copy vimrc to home directory
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

cd "$parent_path"
cp .vimrc ~/

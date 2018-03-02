# Get the current directory path to run commands relative to current location
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

export LSCOLORS="EHfxcxdxBxegecabagacad"

. ./bash/config
. ./bash/env
. ./bash/aliases
# anything added to bin is added on class path
[ -d /bin ] && export PATH=/bin:$PATH

# Setup FZF to search files
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# Copy vimrc to home directory
cp .vimrc ~/
# Copy tmux.conf to home director
cp .tmux.conf ~/

# Reposition current directory to be home
cd

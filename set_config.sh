function git_file() {
  # Assign the arguments to variables
  REPO=$1
  FILE=$2
  STORE=${3:-.}

  # Use curl to download the file from the repository
  curl -o $STORE/$FILE https://raw.githubusercontent.com/$REPO/main/$FILE
}


mkdir -p ~/.config/{tmux,helix}
git_file mazahd/config tmux.conf ~/.config/tmux/
git_file mazahd/config config.toml ~/.config/helix/

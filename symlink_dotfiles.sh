#!/bin/bash

# Script to create a symlink in $HOME for each dotfile in the dotfiles directory - courtesy of ChatGPT

# Directory containing dotfiles
DOTFILES_DIR="$HOME/.dotfiles"

# Target directory (usually home)
TARGET_DIR="$HOME"

# Loop through all files in the dotfiles directory
for file in "$DOTFILES_DIR"/.*; do
  # Skip special files '.' and '..'
  [ "$(basename "$file")" == "." ] || [ "$(basename "$file")" == ".." ] && continue

  # Skip .git
  [ "$(basename "$file")" == ".git" ] && continue

  # Target symlink location
  target="$TARGET_DIR/$(basename "$file")"

  # Create the symlink, backing up the original file if it exists
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "Backing up existing file: $target to $target.bak"
    mv "$target" "$target.bak"
  fi

  echo "Creating symlink: $target -> $file"
  ln -s "$file" "$target"
done

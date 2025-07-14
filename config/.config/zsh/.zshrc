eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias g="git"
alias kitty='kitty -o allow_remote_control=yes --single-instance --listen-on unix:@mykitty'

autoload -U compinit; compinit   # Initialize the completion

source <(kubectl completion zsh)
source <(minikube completion zsh)
source <(colima completion zsh)

# Navigate comp menu using hjkl
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Edit command lines using hjlk
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line


# ZSH Texxt Objects
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# Surrounding
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -M vicmd cs change-surround
bindkey -M vicmd ds delete-surround
bindkey -M vicmd ys add-surround
bindkey -M visual S add-surround



# Options

setopt HIST_SAVE_NO_DUPS    # Do not write a duplicate event to the history file.
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.


zstyle ':completion:*' menu select                                        # Allow you to select in a menu
zstyle ':completion:*' use-cache on                                       # Cache completions
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"       # Cache location

# Misc

bindkey -s ^f "tmux-sessionizer\n" 
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey -v '^?' backward-delete-char

alias claude="/Users/thiagofelix/.claude/local/claude"

# Download a GitHub subdirectory from a tree URL
# Usage: gget <github_tree_url> <subdir>
gget() {
  # Check for required arguments
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: gget <github_tree_url> <subdir>"
    return 1
  fi

  # Parse the GitHub tree URL
  if [[ "$1" =~ ^https?://github\.com/([^/]+)/([^/]+)/tree/([^/]+) ]]; then
    user="${match[1]}"
    repo="${match[2]}"
    branch="${match[3]}"
    subdir="$2"
    archive_url="https://github.com/$user/$repo/archive/refs/heads/$branch.tar.gz"

    echo "Downloading from:"
    echo "  User: $user"
    echo "  Repo: $repo"
    echo "  Branch: $branch"
    echo "  Subdir: $subdir"
    echo "  Archive URL: $archive_url"

    echo "\nDownloading archive..."
    tmpdir="$(mktemp -d)"

    # Download and extract the archive
    if ! curl -sL "$archive_url" | tar -xz -C "$tmpdir"; then
      echo "Error: Failed to download or extract the archive"
      rm -rf "$tmpdir"
      return 1
    fi

    src_path="$tmpdir/$repo-$branch/$subdir"

    if [[ -d "$src_path" ]]; then
      cp -r "$src_path" ./
      echo "Successfully downloaded: $subdir"
    else
      echo "Error: Subdirectory '$subdir' not found in the repository"
    fi

    # Clean up
    rm -rf "$tmpdir"
  else
    echo "Error: Invalid GitHub tree URL. URL must be in format: https://github.com/user/repo/tree/branch"
    return 1
  fi
}

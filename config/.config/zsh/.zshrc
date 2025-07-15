# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================================
# ZINIT INITIALIZATION
# ============================================================================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# ============================================================================
# PLUGINS
# ============================================================================

# Syntax highlighting (must be loaded before autosuggestions)
zinit light zsh-users/zsh-syntax-highlighting

# Autosuggestions
zinit light zsh-users/zsh-autosuggestions

# Completions
zinit light zsh-users/zsh-completions

# Better history search
zinit light zsh-users/zsh-history-substring-search

# Fast directory jumping
zinit light agkozak/zsh-z

# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

# Load zsh-vi-mode for vi keybindings
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# Load completions
autoload -U compinit && compinit

# Disable instant prompt
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh



# ============================================================================
# ===========================================================================
 
source <(kubectl completion zsh)
source <(colima completion zsh)

alias g="git"
alias kitty='kitty -o allow_remote_control=yes --single-instance --listen-on unix:@mykitty'
alias claude="/Users/thiagofelix/.claude/local/claude"

bindkey -s ^f "tmux-sessionizer\n" 


# ============================================================================
# gget
# ===========================================================================
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

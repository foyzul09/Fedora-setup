# --- ZSH CONFIGURATION START ---

# Ensure glob patterns don't cause errors if no files match (MUST BE FIRST)
unsetopt nomatch

# --- ALWAYS CLEAR PROBLEMATIC ZSH CACHES ---
# This command ensures a clean Zsh startup by removing potentially stale or
# problematic cache files that can cause Powerlevel10k warnings or prevent
# startup scripts from displaying consistently.
rm -f ~/.zcompdump* ~/.cache/p10k-instant-prompt*

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set the Oh My Zsh theme. Set to an empty string for Starship.
# If you want Powerlevel10k to be your prompt, set ZSH_THEME="powerlevel10k/powerlevel10k"
# and remove the `eval "$(starship init zsh)"` line at the end.
# If you want Starship, keep ZSH_THEME="" and keep the starship init line.
ZSH_THEME=""

# Plugins
plugins=(
    git
    sudo
    zsh-autosuggestions
    zsh-syntax-highlighting
    history-substring-search
    z
    web-search
    extract
    fzf
    colored-man-pages
    ubuntu
)

# Source Oh My Zsh framework. This must be near the beginning.
source "$ZSH/oh-my-zsh.sh"

# Aliases
alias c='clear'
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'
alias vc='code'

# General system update (for Debian/PikaOS)
alias update='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
# Navigate to config directory
alias cdconf='cd ~/.config'
# Clear relevant caches (helpful for prompt issues)
alias cleancache='rm -rf ~/.zcompdump* ~/.cache/p10k-instant-prompt* ~/.cache/fastfetch'

alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias mkdir='mkdir -p'

# Environment Variables
export EDITOR="code"

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

# Standard Zsh completion styles
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ''
zstyle ':completion:*:processes' list-colors '=(#b) # (=(#b) #) #:(#b) #=(#b) #'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) # (=(#b) #) #:(#b) #=(#b) #'
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) # (=(#b) #) #:(#b) #=(#b) #'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':history-search-end' show-completion-menu yes
zstyle ':completion:*' rehash true
zstyle ':completion:*' completer _complete _ignored _match _correct _approximate
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' verbose yes
zstyle ':completion:*' max-matches 1000
zstyle ':completion:*' insert-tab true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' select-prompt %S
zstyle ':completion:*' original true
zstyle ':completion:*' show-ambiguity yes
zstyle ':completion:*' show-completion-menu yes
zstyle ':completion:*' expand true
zstyle ':completion:*' menu select=long
zstyle ':completion:*' accept-line
zstyle ':completion:*' force-list always
zstyle ':completion:*' auto-description 'specify description'
zstyle ':completion:*' use-menu-completion true
zstyle ':completion:*' group-header '%B%d%b'
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:warnings' format '%B%d%b'
zstyle ':completion:*:messages' format '%B%d%b'
zstyle ':completion:*:options' format '%B%d%b'
zstyle ':completion:*:errors' format '%B%d%b'
zstyle ':completion:*:corrections' format '%B%d%b'
zstyle ':completion:*:approximate' format '%B%d%b'
zstyle ':completion:*:matches' format '%B%d%b'
zstyle ':completion:*:default' group-order ''
zstyle ':completion:*:default' use-list yes
zstyle ':completion:*' list-colors '=(#b) #=(#b) # (=(#b) #) #:(#b) #=(#b) #'
zstyle ':completion:*' sort false
zstyle ':completion:*' show-matches true
zstyle ':completion:*' skip-identical-matches true
zstyle ':completion:*' select-group ''
zstyle ':completion:*' ignore-case true
zstyle ':completion:*' fuzzy-match true
zstyle ':completion:*' format '(%d) '
zstyle ':completion:*' verbose false
zstyle ':completion:*' max-lines 0
zstyle ':completion:*' prefix-needed false
zstyle ':completion:*' add-space true
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' remove-all-dups false
zstyle ':completion:*' expand-or-complete true
zstyle ':completion:*' auto-menu true
zstyle ':completion:*' use-single-line-menu false
zstyle ':completion:*' show-urls true
zstyle ':completion:*' show-tooltip true
zstyle ':completion:*' show-completion-menu true
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' add-space true
zstyle ':completion:*' menu select=auto
zstyle ':completion:*' expand-or-complete true
zstyle ':completion:*' auto-menu true
zstyle ':completion:*' use-single-line-menu false
zstyle ':completion:*' show-urls true
zstyle ':completion:*' show-tooltip true
zstyle ':completion:*' show-completion-menu true
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' add-space true
zstyle ':completion:*' menu select=auto

typeset -ga postcmd_functions
typeset -ga chpwd_functions

# --- STARSHIP PROMPT INITIALIZATION ---
# This must be the very last line in your ~/.zshrc for Starship to work correctly.
eval "$(starship init zsh)"

# --- Startup fastfetch using your custom script ---
# This ensures fastfetch.sh is run only when a new interactive shell starts
# and only if it hasn't run already in this session.
if [[ $- == *i* && -z "$_FASTFETCH_INITIAL_RUN" ]]; then
    clear # Clear the screen before fastfetch output
    if command -v fastfetch >/dev/null; then
        # Capture the options from fastfetch.sh into an array
        local fastfetch_opts=( $(~/.local/bin/fastfetch.sh) )

        # Execute fastfetch with the captured options
        fastfetch "${fastfetch_opts[@]}"
    fi
    typeset -g _FASTFETCH_INITIAL_RUN=1 # Mark that it has run for this session
fi

# Created by `pipx` on 2025-07-18 19:48:34
export PATH="$PATH:/home/ackerman/.local/bin"

# --- ZSH CONFIGURATION END ---

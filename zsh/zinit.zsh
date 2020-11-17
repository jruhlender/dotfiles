typeset -g MY_ZSH_CONFIG_PATH=${ZDOTDIR:-$HOME/.config/zinit}
typeset -g MY_ZINIT_PATH=${ZDOTDIR:-$HOME}/.zinit

HISTFILE=$MY_ZSH_CONFIG_PATH/zsh_history

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ ! -f $MY_ZINIT_PATH/bin/zinit.zsh ] && ((${+commands[git]})); then
    __zinit_just_installed=1
    mkdir -p $MY_ZINIT_PATH && chmod g-rwX "$MY_ZINIT_PATH" && \
      git clone --depth=1 https://github.com/zdharma/zinit.git $MY_ZINIT_PATH/bin
  fi

  if [ -f $MY_ZINIT_PATH/bin/zinit.zsh ]; then
    declare -A ZINIT

    ZINIT[HOME_DIR]="$MY_ZINIT_PATH"

    source $MY_ZINIT_PATH/bin/zinit.zsh

    if [ -z "$skip_global_compinit" ]; then
      autoload -Uz _zinit
      (( ${+_comps} )) && _comps[zinit]=_zinit
    fi

    [ -n "$__zinit_just_installed" ] && \
        zinit self-update

    unset MY_ZINIT_PATH # Use ZINIT[HOME_DIR] from now on

    [ ${${(s:.:)ZSH_VERSION}[1]} -ge 5 ] && [ ${${(s:.:)ZSH_VERSION}[2]} -gt 2 ] && \
      MY_ZINIT_USE_TURBO=true
fi

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# This would turbo-load p10k, but it's not compatible with p10k instant mode
# zinit wait='!' depth=1 lucid nocd \
#     atload='_p9k_precmd' for \
#         romkatv/powerlevel10k

# Using normal load works
zinit depth=1 lucid nocd for \
    romkatv/powerlevel10k

_my_zsh_custom_plugins=(
    zsh-users/zsh-autosuggestions
    zdharma/fast-syntax-highlighting
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-completions
    micha/resty
    supercrabtree/k
    rupa/z
    ael-code/zsh-colored-man-pages
    wfxr/forgit
    junegunn/fzf
    paulirish/git-open
    djui/alias-tips
    joshuarubin/zsh-homebrew
    mrowa44/emojify
    rutchkiwi/copyzshell
    webyneter/docker-aliases
    unixorn/docker-helpers.zshplugin
    changyuheng/fz
    iam4x/zsh-iterm-touchbar
)

typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=true
typeset -g ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

__zinit_plugin_loaded_callback() {
    if [[ "$ZINIT[CUR_PLUGIN]" == "zsh-autosuggestions" ]]; then
        ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${ZSH_AUTOSUGGEST_ACCEPT_WIDGETS[@]/forward-char}")
        ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=forward-char
    elif [[ "$ZINIT[CUR_PLUGIN]" == "zsh-history-substring-search" ]]; then
        bindkey "\ek" history-substring-search-up
        bindkey "\ej" history-substring-search-down
    fi
}

zinit wait lucid depth=1  \
    atload='__zinit_plugin_loaded_callback' \
    for ${_my_zsh_custom_plugins[@]}

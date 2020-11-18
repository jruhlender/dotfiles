typeset -g MY_ZSH_CONFIG_PATH=${ZDOTDIR:-$HOME/.config/zinit}
typeset -g MY_ZINIT_PATH=${ZDOTDIR:-$HOME}/.zinit

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
        #autoload -Uz _zinit
        #(( ${+_comps} )) && _comps[zinit]=_zinit

        autoload -Uz compinit
        compinit
        source <(kubectl completion zsh)
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
# bobsoppe/zsh-ssh-agent

typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=true
typeset -g ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

__zinit_plugin_loaded_callback() {
    if [[ "$ZINIT[CUR_PLUGIN]" == "zsh-autosuggestions" ]]; then
        #ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${ZSH_AUTOSUGGEST_ACCEPT_WIDGETS[@]/forward-char}")
        #ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=forward-char
        ZSH_AUTOSUGGEST_STRATEGY=(history completion)
        ZSH_AUTOSUGGEST_USE_ASYNC=1
        ZSH_AUTOSUGGEST_HISTORY_IGNORE=(cd *)
    elif [[ "$ZINIT[CUR_PLUGIN]" == "zsh-history-substring-search" ]]; then
        bindkey "^[[A" history-substring-search-up
        bindkey "^[[B" history-substring-search-down
        HISTORY_SUBSTRING_SEARCH_FUZZY=1
    fi
}

zinit wait lucid depth=1  \
    atload='__zinit_plugin_loaded_callback' \
    for ${_my_zsh_custom_plugins[@]}

zinit ice proto'git' pick'init.sh'
zinit light b4b4r07/enhancd
export ENHANCD_FILTER=fzf:fzy:peco
export ENHANCD_DOT_ARG="..."
export ENHANCD_DISABLE_HOME=1

# Setup dtags
command -v dtags-activate > /dev/null 2>&1 && eval "`dtags-activate zsh`"
unalias -m 't'
unalias -m 'u'
unalias -m 'd'
unalias -m 'e'
unalias -m 'p'
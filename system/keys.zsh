# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias githubkey="jq -r '.\"github-oauth\".\"github.com\"' ~/.composer/auth.json | pbcopy"

# Set $TERM for ssh to something not custom
# function ssh; env TERM="xterm-256color" /usr/local/bin/ssh $argv; end
# Universal ignore for ag
function ag; /usr/bin/ag --path-to-ignore ~/.config/ag/ignore --hidden $argv; end
# SSH to Dreamhost:
function pilsch.com; ssh eschaton@birkenfeld.dreamhost.com; end
# Load RBEnv
# if command -sq rbenv
# 	status --is-interactive; and source (rbenv init - | sed 's/setenv/set -gx/' | psub)
# end

#set -gx PATH /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
# Configure FZF to us Ag:
set -gx FZF_DEFAULT_COMMAND 'ag --nocolor -g ""'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_DEFAULT_OPTS '
  --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
  --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  '

# Anaconda Setup:
#set -gx PATH /anaconda3/bin $PATH
#source /anaconda3/etc/fish/conf.d/conda.fish

# Sets up Rust's Cargo thing:
# if test -e $HOME/.cargo/env
# 	source $HOME/.cargo/env
# end

# Setup virtualenv support Fish:
# eval (python3 -m virtualfish)

# Setup Fuck:
if command -sq thefuck
	thefuck --alias | source
end
set -g fish_user_paths ~/.local/bin

# Setup NPM:
#status --is-interactive; and source (nodenv init -|psub)

mkdir -p "${HOME}/.profile.d"
cat > "${HOME}/.profile.d/10-editor.sh" << EOF
# Set 'emacsclient' as default editor
EDITOR="emcl"
GIT_EDITOR="\${EDITOR} --no-fork"
SUDO_EDITOR="\${EDITOR} --no-fork"
export EDITOR GIT_EDITOR SUDO_EDITOR
EOF

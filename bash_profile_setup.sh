#!/bin/bash

# adds common env context that comes in handy.
# maps the ssh-agent socket.
 cat <<-EOF >> ~/.bash_profile
export HISTCONTROL=\$HISTCONTROL:ignorespace

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval \`ssh-agent\`
  ln -sf "\$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

EOF

# kills the ssh-agent started on login when 'exit' or 'logout' used
 cat <<-EOF >> ~/.bash_logout

if [ -n "\$SSH_AUTH_SOCK" ] ; then
  eval \`/usr/bin/ssh-agent -k\`
fi

EOF

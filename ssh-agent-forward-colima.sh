#!/usr/bin/env bash

# For better readability and debugging
set -e
set -o pipefail

# Stop Colima
colima stop

# Start the SSH agent
eval "$(ssh-agent -s)"

# Add SSH key
ssh-add ~/.ssh/id_rsa

# Start Colima with the SSH agent
colima start --ssh-agent

# Unset the SSH_AUTH_SOCK variable
unset SSH_AUTH_SOCK

# Export the SSH_AUTH_SOCK variable
export SSH_AUTH_SOCK=$(colima ssh env | grep SSH_AUTH_SOCK | cut -d = -f 2)

# Display the variable to verify
echo "SSH_AUTH_SOCK is set to: $SSH_AUTH_SOCK"

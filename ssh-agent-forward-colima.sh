#!/usr/bin/env bash

# For better readability and debugging
set -e
set -o pipefail

# Stop Colima
colima stop

# Start the SSH agent
eval "$(ssh-agent -s)"

DIR="$HOME/.ssh"
if [ -d "$DIR" ]; then
  # Iterate over all private key files in the ~/.ssh/ directory
  for FILE in "$DIR"/*; do
    # Basename of the file
    BASENAME=$(basename "$FILE")
    # Check if the file does not have the .pub extension and is not named 'config' or 'known_hosts'
    if [[ "$BASENAME" != *.pub && "$BASENAME" != config && "$BASENAME" != known_hosts* ]]; then
        # Add SSH key
        ssh-add "$FILE"
    fi
  done
else
  echo "The directory $DIR does not exist."
  exit
fi

# Start Colima with the SSH agent
colima start --ssh-agent

# Export the SSH_AUTH_SOCK variable
export SSH_AUTH_SOCK=$(colima ssh env | grep SSH_AUTH_SOCK | cut -d = -f 2)

# Display the variable to verify
echo "SSH_AUTH_SOCK is set to: $SSH_AUTH_SOCK"

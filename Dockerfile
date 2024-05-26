FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y openssh-server openssh-client git

# Set environment variable for ssh-agent
# ENV SSH_AUTH_SOCK=/ssh-agent

# Set default command
CMD ["bash"]

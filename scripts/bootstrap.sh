#!/bin/bash

# Enable strict mode:
set -euo pipefail

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~ Bootstrapping                                                                   ~"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

echo "Installing extra packages..."
yum install git -y

echo "Setting up rootless parameters in the system..."
cat <<EOT > /etc/sysctl.d/51-rootless.conf
user.max_user_namespaces = 28633
EOT
sysctl --system

echo "Creating a docker user 'docky'..."
useradd docky
echo 'docky:test1234' | chpasswd
usermod -aG wheel docky

echo "Adding the mappings to subuid and subgid files..."
echo "docky:100000:65536" >> tee /etc/subuid
echo "docky:100000:65536" >> tee /etc/subgid

echo "Adding env variables to bash..."
cat <<EOF > /home/docky/.bashrc
export XDG_RUNTIME_DIR=/home/docky/.docker/run
export PATH=/home/docky/bin:$PATH
export DOCKER_HOST=unix://\${XDG_RUNTIME_DIR}/docker.sock
EOF

echo "Running docker rootless script..."
sudo -H -u docky bash -c "curl -sSL https://get.docker.com/rootless | bash"

echo "Starting docker daemon as docky user..."
sudo -H -u docky bash -c "source /home/docky/.bashrc && /home/docky/bin/dockerd-rootless.sh"
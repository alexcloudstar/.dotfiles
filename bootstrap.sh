#!/usr/bin/env bash
set -euo pipefail

# Bootstrap a fresh macOS machine:
#   1. Install Xcode Command Line Tools (needed for git, clang)
#   2. Install Homebrew
#   3. Install Ansible via Homebrew
#   4. Install required Ansible collections
#   5. Run the playbook

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "bootstrap.sh only supports macOS" >&2
  exit 1
fi

if ! xcode-select -p >/dev/null 2>&1; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install || true
  until xcode-select -p >/dev/null 2>&1; do sleep 10; done
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v ansible-playbook >/dev/null 2>&1; then
  echo "Installing Ansible..."
  brew install ansible
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}/ansible"

ansible-galaxy collection install -r requirements.yml

ansible-playbook site.yml --ask-become-pass "$@"

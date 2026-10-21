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

# Rosetta shells report proc_translated=1; Intel-arch shells on Apple Silicon report x86_64.
if [[ "$(sysctl -n sysctl.proc_translated 2>/dev/null || echo 0)" == "1" ]] \
  || [[ "$(uname -m)" == "x86_64" && "$(sysctl -n hw.optional.arm64 2>/dev/null || echo 0)" == "1" ]]; then
  echo "bootstrap.sh is running under Rosetta (x86_64 shell on Apple Silicon)." >&2
  echo "Run it from a native arm64 terminal: uncheck 'Open using Rosetta' for Terminal/iTerm2 in Get Info, then retry." >&2
  exit 1
fi

if ! xcode-select -p >/dev/null 2>&1; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install || true
  until xcode-select -p >/dev/null 2>&1; do sleep 10; done
fi

if [[ ! -x /opt/homebrew/bin/brew ]]; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

if ! command -v ansible-playbook >/dev/null 2>&1; then
  echo "Installing Ansible..."
  brew install ansible
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}/ansible"

ansible-galaxy collection install -r requirements.yml

ansible-playbook site.yml --ask-become-pass "$@"

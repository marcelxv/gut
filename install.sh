#!/usr/bin/env bash
#
# gut installer
#

set -e

INSTALL_DIR="${GUT_INSTALL_DIR:-$HOME/.local/bin}"

echo "🧑‍🍳 Installing gut..."

# Create install directory if needed
mkdir -p "$INSTALL_DIR"

# Copy gut to install directory
cp gut "$INSTALL_DIR/gut"
chmod +x "$INSTALL_DIR/gut"

echo "✅ Installed to $INSTALL_DIR/gut"

# Check if in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "⚠️  $INSTALL_DIR is not in your PATH"
    echo ""
    echo "Add this to your ~/.bashrc or ~/.zshrc:"
    echo ""
    echo "    export PATH=\"\$PATH:$INSTALL_DIR\""
    echo ""
fi

echo ""
echo "Get cooking:"
echo "  gut help        Show commands"
echo "  gut init        Set up a project"
echo ""

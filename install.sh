#!/usr/bin/env bash
# Everything Gemini and Antigravity (EGA) - POSIX 1-Click Bootstrap Installer
# Installs EGA globally as an Antigravity plugin with zero repository clutter.

set -euo pipefail

REPO_URL="https://github.com/gamiheme/ega.git"

echo ""
echo "=========================================================="
echo "  Everything Gemini and Antigravity (EGA) v2.3.0"
echo "  The Harness-Native Super-Plugin for Antigravity"
echo "=========================================================="
echo ""

# Check for Antigravity CLI
if command -v agy >/dev/null 2>&1; then
    echo "[*] Antigravity CLI detected."
    echo "[*] Installing EGA via Antigravity Plugin Engine..."
    if agy plugin install https://github.com/gamiheme/ega; then
        echo ""
        echo "[+] EGA successfully installed globally!"
        echo "    72 Subagents | 425 Skills | 122 Rules | 37 MCPs | 9 Hooks"
        echo ""
        echo "Run 'agy plugin list' to verify."
        exit 0
    else
        echo "[!] Plugin install returned an error. Falling back to direct clone..."
    fi
fi

# Direct installation path fallback
PLUGINS_DIR="$HOME/.gemini/config/plugins"
TARGET_DIR="$PLUGINS_DIR/ega"

mkdir -p "$PLUGINS_DIR"

if [ -d "$TARGET_DIR" ]; then
    echo "[*] Updating existing EGA installation at $TARGET_DIR..."
    if [ -d "$TARGET_DIR/.git" ]; then
        git -C "$TARGET_DIR" pull --ff-only
        echo "[+] EGA successfully updated!"
        exit 0
    else
        echo "[!] Target directory exists without .git. Re-cloning..."
        rm -rf "$TARGET_DIR"
    fi
fi

echo "[*] Cloning EGA into: $TARGET_DIR"
git clone --depth 1 "$REPO_URL" "$TARGET_DIR"

echo ""
echo "[+] EGA installed globally in $TARGET_DIR"
echo "    EGA is now immediately active across all Antigravity sessions and workspaces."
echo ""

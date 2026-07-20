#!/bin/sh

echo "=== DEBUG: Searching for xray ==="

# Ищем xray во всех возможных местах
find / -name xray 2>/dev/null
echo "---"
ls -la /usr/bin/xray 2>/dev/null || echo "not in /usr/bin"
ls -la /usr/local/bin/xray 2>/dev/null || echo "not in /usr/local/bin"
ls -la /bin/xray 2>/dev/null || echo "not in /bin"
ls -la /xray 2>/dev/null || echo "not in /"
which xray 2>/dev/null || echo "which: not found"
echo "---"
echo "PATH: $PATH"
echo "---"
ls -la / 2>/dev/null | head -20

echo "=== DEBUG END ==="

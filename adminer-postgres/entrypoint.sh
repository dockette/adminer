#!/bin/bash
set -Eeo pipefail

if [ "${ADMINER_DEBUG}" = "1" ]; then
  set -o xtrace
fi

# Banner
if [ "${ADMINER_BANNER}" != "0" ] && [ "${ADMINER_BANNER}" != "false" ] && [ "${ADMINER_BANNER}" != "no" ] && [ "${ADMINER_BANNER}" != "off" ]; then
  cat << 'EOF'
 █████╗ ██████╗ ███╗   ███╗██╗███╗   ██╗███████╗██████╗
██╔══██╗██╔══██╗████╗ ████║██║████╗  ██║██╔════╝██╔══██╗
███████║██║  ██║██╔████╔██║██║██╔██╗ ██║█████╗  ██████╔╝
██╔══██║██║  ██║██║╚██╔╝██║██║██║╚██╗██║██╔══╝  ██╔══██╗
██║  ██║██████╔╝██║ ╚═╝ ██║██║██║ ╚████║███████╗██║  ██║
╚═╝  ╚═╝╚═════╝ ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝
EOF
fi

echo "[adminer] Loading Adminer (PostgreSQL)..."

# Copy theme CSS files based on ADMINER_THEME environment variable
if [ -n "${ADMINER_THEME}" ]; then
    THEME_DIR="/srv/designs/${ADMINER_THEME}"
    if [ -d "${THEME_DIR}" ]; then
        if [ -f "${THEME_DIR}/adminer.css" ]; then
            cp "${THEME_DIR}/adminer.css" /srv/adminer.css
            echo "[adminer] Theme '${ADMINER_THEME}' applied successfully."
        else
            echo "[adminer] Warning: Theme '${ADMINER_THEME}' does not contain adminer.css"
        fi
        if [ -f "${THEME_DIR}/adminer-dark.css" ]; then
            cp "${THEME_DIR}/adminer-dark.css" /srv/adminer-dark.css
            echo "[adminer] Dark mode CSS for theme '${ADMINER_THEME}' applied."
        fi
    else
        echo "[adminer] Warning: Theme '${ADMINER_THEME}' not found in /srv/designs/"
        echo "[adminer] Available themes:"
        ls -1 /srv/designs/ 2>/dev/null || echo "[adminer] No themes available."
    fi
fi

# Set default values if not provided
MEMORY=${MEMORY:-256M}
UPLOAD=${UPLOAD:-2048M}
PORT=${PORT:-80}

echo "[adminer] Starting PHP server (http://0.0.0.0:${PORT} in Docker):"
echo "-> memory_limit=${MEMORY}"
echo "-> upload_max_filesize=${UPLOAD}"
echo "-> post_max_size=${UPLOAD}"
echo "-> port=${PORT}"

# Execute PHP server
exec php \
    -d "memory_limit=${MEMORY}" \
    -d "upload_max_filesize=${UPLOAD}" \
    -d "post_max_size=${UPLOAD}" \
    -S "0.0.0.0:${PORT}"

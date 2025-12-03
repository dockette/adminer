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

echo "[adminer] Loading Adminer..."

# Copy driver plugins from /srv/plugins/drivers to /srv/adminer-plugins
if [ -d "/srv/plugins/drivers" ]; then
    cp -r /srv/plugins/drivers/* /srv/adminer-plugins/ 2>/dev/null || true
    echo "[adminer] Driver plugins copied successfully."
else
    echo "[adminer] No driver plugins directory found at /srv/plugins/drivers, skipping..."
fi

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

echo "[adminer] Starting PHP server (http://0.0.0.0:80 in Docker):"
echo "-> memory_limit=${MEMORY}"
echo "-> upload_max_filesize=${UPLOAD}"
echo "-> post_max_size=${UPLOAD}"

# Execute PHP server
exec php \
    -d "memory_limit=${MEMORY}" \
    -d "upload_max_filesize=${UPLOAD}" \
    -d "post_max_size=${UPLOAD}" \
    -S 0.0.0.0:80

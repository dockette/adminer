<?php

/**
 * Server list with optional stored credentials and Auto Sign-In button.
 * Credentials are handled server-side — never exposed to the browser.
 *
 * Activated by: ADMINER_SERVERS_* env vars
 * DSN format:   driver://username:password@host:port/database
 * Examples:
 *   ADMINER_SERVERS_MariaDB=server://root:secret@mysql:3306/mydb
 *   ADMINER_SERVERS_PostgreSQL=pgsql://postgres:pwd@pg:5432/app
 *   ADMINER_SERVERS_SQLite=sqlite:///data/db.sqlite  (no credentials)
 *
 * The suffix after ADMINER_SERVERS_ becomes the display name in the dropdown.
 */
class AdminerServerList extends Adminer\Plugin {
    private $servers = [];
    private $credentials = [];

    function __construct() {
        foreach (getenv() as $key => $value) {
            if (!str_starts_with($key, 'ADMINER_SERVERS_')) {
                continue;
            }
            $name = substr($key, strlen('ADMINER_SERVERS_'));
            if (!preg_match('#^(\w+)://(?:([^:@]*)(?::([^@]*))?@)?([^/:]+)(?::(\d+))?(?:/(.*))?$#', $value, $m)) {
                continue;
            }
            $host = $m[4] . (!empty($m[5]) ? ':' . $m[5] : '');
            $this->servers[$name] = ['server' => $host, 'driver' => $m[1]];
            if (!empty($m[2])) {
                $this->credentials[$name] = [
                    'username' => urldecode($m[2]),
                    'password' => urldecode($m[3] ?? ''),
                    'db' => urldecode($m[6] ?? ''),
                ];
            }
        }

        // Set driver from selected server on POST (same as AdminerLoginServers)
        if ($_POST["auth"] && isset($this->servers[$_POST["auth"]["server"]])) {
            $_POST["auth"]["driver"] = $this->servers[$_POST["auth"]["server"]]["driver"];
        }

        // Handle Auto Sign-In: inject stored credentials into POST
        if (isset($_POST["_autologin"]) && isset($this->credentials[$_POST["auth"]["server"]])) {
            $cred = $this->credentials[$_POST["auth"]["server"]];
            $_POST["auth"]["username"] = $cred["username"];
            $_POST["auth"]["password"] = $cred["password"];
            $_POST["auth"]["db"] = $cred["db"];
        }
    }

    function credentials() {
        $server = Adminer\SERVER;
        if (isset($this->servers[$server])) {
            $host = $this->servers[$server]["server"];
            if (isset($this->credentials[$server])) {
                $cred = $this->credentials[$server];
                $username = $_GET["username"] ?: $cred["username"];
                $password = Adminer\get_password() ?: $cred["password"];
                return [$host, $username, $password];
            }
            return [$host, $_GET["username"], Adminer\get_password()];
        }
    }

    function login($login, $password) {
        if (!isset($this->servers[Adminer\SERVER])) {
            return false;
        }
        if (isset($this->credentials[Adminer\SERVER])) {
            return true;
        }
    }

    function loginFormField($name, $heading, $value) {
        if ($name == 'driver') {
            return '';
        }
        if ($name == 'server') {
            return $heading . Adminer\html_select("auth[server]", array_keys($this->servers), Adminer\SERVER) . "\n";
        }
    }

    function head() {
        if (isset($_GET["username"]) || empty($this->credentials)) {
            return;
        }
        $servers = json_encode(array_keys($this->credentials), JSON_HEX_TAG | JSON_HEX_AMP);
        $nonce = \Adminer\get_nonce();
        echo <<<SCRIPT
<script nonce="$nonce">
(function() {
    var serversWithCreds = $servers;
    document.addEventListener("DOMContentLoaded", function() {
        var form = document.querySelector("form");
        if (!form) return;
        var serverSelect = form.querySelector('[name="auth[server]"]');
        if (!serverSelect) return;

        var hidden = document.createElement("input");
        hidden.type = "hidden";
        hidden.name = "_autologin";
        hidden.disabled = true;
        form.appendChild(hidden);

        var btn = document.createElement("input");
        btn.type = "submit";
        btn.value = "Auto Sign-In";
        btn.style.display = "none";
        btn.style.marginLeft = "5px";
        btn.addEventListener("click", function() {
            hidden.disabled = false;
            hidden.value = "1";
        });
        var loginBtn = form.querySelector('[type="submit"][value="Login"]');
        if (loginBtn) loginBtn.parentNode.insertBefore(btn, loginBtn.nextSibling);

        function updateButton(serverName) {
            btn.style.display = serversWithCreds.indexOf(serverName) >= 0 ? "inline" : "none";
        }
        serverSelect.addEventListener("change", function() { updateButton(this.value); });
        updateButton(serverSelect.value);
    });
})();
</script>
SCRIPT;
    }
}

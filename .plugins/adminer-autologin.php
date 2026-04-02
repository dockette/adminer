<?php

/**
 * Auto-login to a single database server. Skips the login form entirely.
 *
 * Activated by: ADMINER_AUTOLOGIN_SERVER env var
 * DSN format:   driver://username:password@host:port/database
 * Example:      server://root:secret@mysql:3306/mydb
 */
class AdminerAutologin extends Adminer\Plugin {
    private $config;

    function __construct() {
        $dsn = getenv('ADMINER_AUTOLOGIN_SERVER');
        if (!$dsn || !preg_match('#^(\w+)://(?:([^:@]*)(?::([^@]*))?@)?([^/:]+)(?::(\d+))?(?:/(.*))?$#', $dsn, $m)) {
            return;
        }
        $host = $m[4] . (!empty($m[5]) ? ':' . $m[5] : '');
        $this->config = [
            'driver' => $m[1],
            'username' => urldecode($m[2] ?? ''),
            'password' => urldecode($m[3] ?? ''),
            'server' => $host,
            'db' => urldecode($m[6] ?? ''),
        ];

        // Inject login data on first visit (before Adminer processes the request)
        if (!isset($_GET["username"]) && empty($_POST["auth"]) && !isset($_GET["server"])) {
            $_POST["auth"] = [
                "driver" => $this->config["driver"],
                "server" => $this->config["server"],
                "username" => $this->config["username"],
                "password" => $this->config["password"],
                "db" => $this->config["db"],
                "permanent" => "",
            ];
        }
    }

    function credentials() {
        if ($this->config) {
            return [$this->config["server"], $this->config["username"], $this->config["password"]];
        }
    }

    function login($login, $password) {
        if ($this->config) {
            return true;
        }
    }
}

<?php

/**
 * Configure MSSQL encryption settings via environment variables.
 *
 * Activated by: ADMINER_PLUGIN_MSSQL_ENCRYPT=1
 * Environment variables:
 *   ADMINER_MSSQL_ENCRYPT        - "yes", "no", or "strict" (default: not set)
 *   ADMINER_MSSQL_TRUST_CERT     - "yes" or "no" (default: "yes")
 */
class AdminerMssqlEncrypt extends Adminer\Plugin {
    private $ssl;

    function __construct() {
        $this->ssl = [];
        $encrypt = getenv('ADMINER_MSSQL_ENCRYPT');
        if ($encrypt !== false) {
            $this->ssl['Encrypt'] = $encrypt;
        }
        $trust = getenv('ADMINER_MSSQL_TRUST_CERT');
        $this->ssl['TrustServerCertificate'] = ($trust !== false) ? $trust : 'yes';
    }

    function connectSsl() {
        return $this->ssl;
    }
}

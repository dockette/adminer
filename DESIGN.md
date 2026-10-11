# Adminer Design

The Adminer images serve the Adminer database UI on port `80`. Developers open it in a browser to inspect and
edit databases in local and staging stacks. The UI is upstream [Adminer](https://www.adminer.org); this file
describes only what the image adds on top of it.

## Principles

- **Upstream UI, unmodified PHP.** The `Dockerfile` downloads the release file `adminer-{version}.php` (or
  `editor-{version}.php`) to `/srv/index.php`; nothing patches it.
- **Everything is opt-in by environment.** Themes and plugins are off until a variable turns them on, so a
  container started with no variables looks like upstream Adminer. The one exception is `mssql`, where
  `mssql-encrypt` is on by default.
- **Credentials never reach the browser.** The server list and autologin plugins parse DSNs from the environment
  on the server; the page only receives server names.
- **One entrypoint per variant.** Each `adminer-{tag}/entrypoint.sh` enables only the features its variant
  supports.

## Inventory

- Login and database screens: upstream `adminer-{version}.php`, served as `/srv/index.php` (`ADMINER_VERSION`).
- Editor screens (`editor` tag): upstream `editor-{version}.php`, the data-only Adminer Editor.
- Server dropdown with Auto Sign-In: `.plugins/adminer-server-list.php`, enabled by `ADMINER_PLUGIN_SERVER_LIST=1`.
- Autologin, which skips the login form: `.plugins/adminer-autologin.php`, enabled by `ADMINER_PLUGIN_AUTOLOGIN=1`.
- MSSQL encryption options: `.plugins/adminer-mssql-encrypt.php`, `mssql` tag only, on unless
  `ADMINER_PLUGIN_MSSQL_ENCRYPT=0`.
- Upstream driver plugins: the release `plugins/drivers/` folder, copied into `/srv/adminer-plugins/` at start,
  `full` tag only.
- Themes: the release `designs/` folder, copied to `/srv/designs/` at build time (not in `dg`).
- The `dg` tag serves the separate `adminer-custom` project with its own look. None of the plugins or themes
  above apply to it.
- The other variants differ in drivers, not in UI: `full`, `mysql`, `postgres`, `mongo`, `mssql`, `oracle-*`.

## Layout

- Upstream. The server list plugin changes the login form: the Server text field becomes a `<select>` of the
  names from `ADMINER_SERVERS_*`, the System (driver) field disappears because the driver comes from the DSN, and
  an Auto Sign-In button appears next to Login.
- Autologin removes the login form from the first visit; the user lands on the database screen.

## Typography

- Upstream theme, or the fonts of the selected design.

## Colors and Themes

- Themes come from the upstream release `designs/` folder, copied to `/srv/designs/` at build time. The list
  changes with the Adminer version.
- `ADMINER_THEME={name}` copies `/srv/designs/{name}/adminer.css` to `/srv/adminer.css` at start, where Adminer
  picks it up, and `adminer-dark.css` too when the theme has one.
- Default: no theme file, upstream look.

## States

- Every start prints a banner (off with `ADMINER_BANNER=0`), `[adminer] Loading Adminer...` and the PHP server
  settings (`memory_limit`, upload limits, port). `ADMINER_DEBUG=1` adds shell tracing.
- Theme applied: `[adminer] Theme '{name}' applied successfully.`
- Unknown theme: a warning and the list of available themes; the UI stays default.
- Theme folder without `adminer.css`: a warning; the UI stays default.
- Plugin enabled: `[adminer] Plugin '{name}' activated.`
- Autologin and server list both enabled: only autologin is activated.
- Server without credentials in its DSN: listed in the dropdown, but needs a manual login; no Auto Sign-In button.
- Invalid DSN: the plugin skips it silently; the server is not listed.

## Accessibility

- Upstream HTML forms. The server list plugin uses the upstream `<select>` helper and a plain
  `<input type="submit">`, both keyboard reachable. Its button is hidden with `display: none` for servers without
  credentials.

## Dark Mode

- Only through a theme that ships `adminer-dark.css`; how it is switched on is upstream behaviour.

## Responsive

- Desktop first, as upstream. Our plugins add no layout of their own and are not tested on narrow screens.

## Screenshots

- `.docs/assets/adminer.png` (default look), `.docs/assets/adminer-dg.png` (`dg` tag) and
  `.docs/assets/themes/{name}.png`, one per theme, shown 200 px wide in the README table.
- To retake one, run `make build-full`, then `docker run --rm -p 8000:80 -e ADMINER_THEME={name}
  dockette/adminer:full`, open `http://localhost:8000` and capture the login screen.
- After an Adminer version bump, retake the default screenshot and check the theme list against `designs/`.

## Changing the UI

- Variable names (`ADMINER_THEME`, `ADMINER_PLUGIN_*`, `ADMINER_SERVERS_*`, `ADMINER_AUTOLOGIN_SERVER`) are
  public; rename them only with a deprecation note in the README.
- A new upstream major can change the plugin API (`Adminer\Plugin`, `loginFormField`, `credentials`); start
  every variant and log in once.
- The server list script finds the Login button by `value="Login"`; an upstream label change hides the Auto
  Sign-In button.
- Adding a theme to the README table needs its screenshot in `.docs/assets/themes/`.

## Checklist

- [ ] The default container (no variables) looks like upstream Adminer
- [ ] Each changed plugin tested with and without credentials, in `full` and one Debian variant
- [ ] `ADMINER_THEME` with a valid and an invalid name
- [ ] No DSN or password appears in the page source
- [ ] `mssql` still connects with `ADMINER_PLUGIN_MSSQL_ENCRYPT` unset and set to `0`
- [ ] Screenshots updated if the UI changed

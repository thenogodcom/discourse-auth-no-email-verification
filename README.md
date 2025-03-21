# discourse-auth-no-email-verification

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/thenogodcom/discourse-auth-no-email-verification)](https://github.com/thenogodcom/discourse-auth-no-email-verification/releases)
[![GitHub license](https://img.shields.io/github/license/thenogodcom/discourse-auth-no-email-verification)](https://github.com/thenogodcom/discourse-auth-no-email-verification/blob/main/LICENSE)

**Description:**  This plugin allows users to register on your Discourse forum without requiring email verification.  This applies to both direct signups and invitations.

**Version:** 2.0

**Author:** thenogodcom

**URL:** [https://github.com/thenogodcom/discourse-auth-no-email-verification](https://github.com/thenogodcom/discourse-auth-no-email-verification)

## Installation

**WARNING:** Disabling email verification can significantly increase the risk of spam and bot registrations.  Use this plugin with caution and consider implementing other anti-spam measures.

1.  **Connect to your server:**  SSH into your Discourse server.

2.  **Navigate to the Discourse directory:**

    ```bash
    cd /var/discourse
    ```

3.  **Edit the `app.yml` file:**

    ```bash
    nano containers/app.yml
    ```

4.  **Add the plugin to the `plugins` section:**

    Inside the `app.yml` file, find the `hooks:` section, and then the `after_code:` section within it.  Add the following line within the `cmd:` array, *after* any other `git clone` commands that might already be there. Make sure to maintain the correct YAML indentation (using spaces, not tabs).

    ```yaml
    hooks:
      after_code:
        cmd:
          - git clone https://github.com/discourse/docker_manager.git  # Example - keep existing lines
          - git clone https://github.com/thenogodcom/discourse-auth-no-email-verification.git
    ```

    **Important:**  The order of plugins *can* matter.  If you have other plugins that modify authentication, you might need to experiment with the order to ensure they all work correctly.  Generally, it's a good idea to put this plugin *after* any official Discourse plugins.

5.  **Rebuild the Discourse container:**

    ```bash
    cd /var/discourse
    ./launcher rebuild app
    ```

    This process may take several minutes.

6.  **Verify Installation (Optional):**

    After the rebuild, log in to your Discourse admin panel and check the list of installed plugins to ensure that "discourse-auth-no-email-verification" is present.

## Usage

Once installed, the plugin automatically disables email verification for all new user registrations and invitations.  There are no settings to configure within the Discourse admin interface.

## Uninstallation

1.  **Edit `app.yml`:**  Remove the `git clone` line you added in step 4.
2.  **Rebuild:** Run `./launcher rebuild app` again.
3.  **(Optional) Remove the plugin directory:** Inside the container (`./launcher enter app`), you can remove the plugin directory (`shared/standalone/plugins/discourse-auth-no-email-verification` or `shared/default/plugins/discourse-auth-no-email-verification` depending on your installation type). This isn't strictly necessary, as the plugin won't be loaded after removing it from `app.yml`.

## Troubleshooting

*   **Plugin not working:**
    *   Double-check that you added the `git clone` line to the correct location in `app.yml` *and* that you rebuilt the container.
    *   Make sure there are no typos in the plugin's URL.
    *   Check the Discourse logs for errors (`./launcher logs app`).
    *   If you have other authentication-related plugins, there might be a conflict. Try disabling other plugins temporarily to see if that resolves the issue.
*   **Spam increase:**  If you experience a significant increase in spam registrations, consider re-enabling email verification or implementing alternative anti-spam measures (e.g., Akismet, custom registration questions, rate limiting).

## Disclaimer

This plugin modifies core Discourse functionality.  Use it at your own risk.  The author is not responsible for any issues that may arise from using this plugin.  It is recommended to test the plugin thoroughly on a staging environment before deploying it to production.

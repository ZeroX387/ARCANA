# Android build and updates

## Package identity

- Android package ID: `com.arcana.game`
- Initial version: `0.1.0`
- Initial version code: `1`
- Godot version used by CI: `4.3`

**Do not change the package ID after the first install.** Every update must use the same release signing key and a higher Android version code.

## Release signing key

The release keystore is not stored in this public repository. Keep a private backup in at least two safe places. Losing it can prevent future APKs from updating an already-installed release.

Create a keystore once with a trusted local `keytool` installation:

```bash
keytool -genkeypair -v -keystore arcana-release.keystore -alias arcana -keyalg RSA -keysize 2048 -validity 10000
```

Use the same keystore, alias, and password for every future release. For this Godot 4.3 preset, use the same password for the keystore and key. Do not send the keystore or password in chat, issues, commits, or public files.

Convert the keystore file to Base64 for a GitHub Actions secret:

```bash
base64 -w 0 arcana-release.keystore
```

On systems where `base64 -w 0` is unsupported, use that system's equivalent command to produce one uninterrupted Base64 string.

## GitHub Actions secrets

In the repository, open **Settings → Secrets and variables → Actions → New repository secret** and add:

| Secret name | Value |
|---|---|
| `ARCANA_KEYSTORE_BASE64` | Entire Base64 string of the keystore |
| `ARCANA_KEYSTORE_PASSWORD` | Keystore/key password (use the same password for both) |
| `ARCANA_KEY_ALIAS` | Alias, initially `arcana` |

Never add these values to repository files. Do not share screenshots showing secret values.

## Build

After all three secrets exist, open **Actions → Android APK → Run workflow**. The APK is uploaded as the workflow artifact `ARCANA-Android-APK` for 30 days.

The workflow currently exports a signed ARM64 APK. It is suitable for compatible modern Android devices. A successful workflow run is required before installing the first build.

## Updating and preserving progress

For an installed app to accept an update without uninstalling:

1. Keep `package/unique_name` equal to `com.arcana.game`.
2. Sign every release with this exact keystore and alias.
3. Increase `version/code` for every new APK (2, 3, 4, ...).
4. Keep saved game data in the app's persistent user-data directory, not in temporary/cache storage.
5. Back up important progress before applying an update. Android's normal APK installer updates the app in place, but a faulty game update can still damage its own save data.

Android will show its system installer/confirmation. A normal app cannot silently install its own APK on standard Android devices.

## Important

The first APK built with this release key becomes the signing identity for installed test/release builds. Keep the keystore private and backed up. If the key is lost or replaced, Android will reject updates signed with the new key; users would generally need to uninstall the old app, which can erase local data.

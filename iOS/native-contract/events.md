# PocLink Native Events

Native sends all PocLink SDK notifications to JavaScript through a small event set.

## Event Names

- `poclink.login`: login success, token invalidation, or another-device login.
- `poclink.groupChanged`: group list changes, current group changes, removed groups, or denied joins.
- `poclink.speaking`: microphone and PTT speaking lifecycle.
- `poclink.session`: full-duplex session and audio-session lifecycle.
- `poclink.error`: normalized SDK errors.
- `poclink.rawNotification`: development-only escape hatch for unmodeled SDK notifications.

## Rules

- IDs such as `uid` and `gid` are always strings.
- Native objects must be converted to JSON-safe dictionaries before crossing the bridge.
- `rawNotification` must not be required for production UI behavior.
- Breaking payload changes require a major native API version bump.

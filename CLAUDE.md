# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run

`Pods/` is gitignored. After cloning, run:
```bash
pod install
```

Always open `poclink-app.xcworkspace` (not `.xcodeproj`) in Xcode, then build and run on a device or simulator. There are no automated tests.

CocoaPods version in use: 1.16.2 (see `Podfile.lock`).

## Architecture

iOS app written in **Objective-C**, targeting iOS 14+. The core is a closed-source PTT (Push-to-Talk) SDK bundled locally at `Frameworks/CmccSDK.framework`.

### SDK entry point

`SUPSDK_M` is a macro for the `SUPSDKManager` singleton — the single gateway for all SDK operations. It is initialized once in `AppDelegate.m`:

```objc
[SUPSDK_M init_dns:@"52.1.120.181:36003,..."
      version_type:APP_VERSION_DEVELOPMENT
          ...
             agent:@"http://agent.poclink.com:36002"
              ...];
```

All SDK events are delivered via `NSNotificationCenter` using `kPOST_CMCC_NOTIFICATION_*` constants defined in `CmccSDK.h`. `AppDelegate` registers the full set of listeners in `setupNotifications`; individual VCs add their own subset.

### Login flow

`LandingViewController` (set as root in `Main.storyboard` via NavigationController) offers two paths:

**Google login** (`GoogleLoginViewController`):
1. `GIDSignIn signInWithPresentingViewController:` → obtain ID token
2. `SUPSDK_M PostAuthWithIdToken:type:email:name:` → get `SUPLoginModel.account`
3. `SUPSDK_M GetServiceUrlWithAccount:` → get `SUPRegionServerModel[]`
4. `SUPSDK_M setExtendUrl:soundRecord:` (extract `serverType == "extend"` and `"soundRecord"`)
5. `SUPSDK_M login_account:password:type:` → triggers `kPOST_CMCC_NOTIFICATION_LOGIN` on success

**Email login** (`EmailLoginViewController`): same steps 3–5, using `PostLoginWithAccount:type:password:code:` instead of Google OAuth. Password is MD5-hashed before sending.

Success of `login_account` is indicated by return value `0`; the async confirmation arrives via the `kPOST_CMCC_NOTIFICATION_LOGIN` notification (payload: `CmccUser`).

### PTT interface

`ViewController` (accessed via "进入首页" or post-login): join a hardcoded group (`join_group_gid:`), then long-press the speak button to call `start_speak:` / `stop_speak`.

### Known issue (see `TODO.md`)

`login_account` returns `-1` for both login methods. The SDK fires `EN_ONLINE_STATUS_CHANGED online=2` then immediately `connection_shutdown`, indicating the voice server connection drops before the login notification fires. The `init_dns` `serviceAudio` parameter is currently an empty string — this is the suspected root cause.

## Key SDK types

| Type | Purpose |
|------|---------|
| `SUPSDKManager` (`SUPSDK_M`) | Singleton SDK facade |
| `CmccUser` | Logged-in user (uid, account, name) |
| `CmccGroup` | Group (gid, name) |
| `CmccSpeak` | PTT speak event |
| `SUPLoginModel` | Auth response (contains `account` needed for `login_account`) |
| `SUPRegionServerModel` | Server URL entry (serverType, regionName, serverUrl) |

## Skill routing

When the user's request matches an available skill, invoke it via the Skill tool. When in doubt, invoke the skill.

Key routing rules:
- Product ideas/brainstorming → invoke /office-hours
- Strategy/scope → invoke /plan-ceo-review
- Architecture → invoke /plan-eng-review
- Design system/plan review → invoke /design-consultation or /plan-design-review
- Full review pipeline → invoke /autoplan
- Bugs/errors → invoke /investigate
- QA/testing site behavior → invoke /qa or /qa-only
- Code review/diff check → invoke /review
- Visual polish → invoke /design-review
- Ship/deploy/PR → invoke /ship or /land-and-deploy
- Save progress → invoke /context-save
- Resume context → invoke /context-restore

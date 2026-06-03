# PocLink Native

This repository owns the native application shell.

## Responsibilities

- iOS and Android app projects.
- React Native 0.81.6 runtime integration.
- Native SDK dependencies such as `CmccSDK.framework`.
- Native modules and event emitters.
- App permissions, bundle IDs, entitlements, URL schemes, and release packaging.
- Loading the built-in JavaScript bundle or a verified hot-update bundle.

## Contract

The public API exposed to JavaScript lives in `native-contract/`.
JavaScript bundles must check `getNativeApiVersion()` before enabling features that depend on native methods or event payloads.

## Current State

The existing iOS proof-of-concept project is preserved in this repository. The next native step is to introduce the React Native 0.81.6 app shell and move the existing `CmccSDK` calls into a `PoclinkSDK` native module.

# Copilot Repository Instructions

These instructions onboard this repository for coding agents. They describe the repository layout, required tools, build and validation steps, and how to reliably work with the project. These instructions are not task-specific and should be reused for all future changes.

## 1. Repository Summary

This repository contains a Flutter package that provides an enhanced dropdown widget usable in Flutter applications. The package is structured as a standard Dart/Flutter package with a runnable example app demonstrating usage. The codebase is small, uses only Dart, and targets Flutter's stable toolchain.

## 2. High-Level Repository Information

**Type:** Flutter package

**Languages:** Dart

**Main directories:**
- `lib/` — package source code
- `example/` — runnable demo app
- `test/` — package tests
- `.github/workflows/` — CI scripts

**Key files:** `pubspec.yaml`, `README.md`, `CHANGELOG.md`

Before making any changes, always inspect `pubspec.yaml` for SDK constraints, dependencies, and package metadata.

## 3. Environment & Bootstrap Instructions

Always perform the following steps when starting work or after switching branches:

1. Ensure a Flutter SDK (stable channel) is installed and available in PATH.

2. Verify the SDK version:
   ```bash
   flutter --version
   ```

3. Install all package dependencies:
   ```bash
   flutter pub get
   ```

4. When working inside the `example/` folder (for running or testing the example app), run `flutter pub get` there as well:
   ```bash
   cd example
   flutter pub get
   cd ..
   ```

## 4. Build, Lint, and Test Instructions

### A. Formatting (must pass before PR)
```bash
flutter format --set-exit-if-changed .
```

### B. Static Analysis
```bash
flutter analyze
```

### C. Run Tests
```bash
flutter test
```

### D. Validate Package for Publishing
```bash
flutter pub publish --dry-run
```

This checks for metadata issues, missing files, and pubspec problems.

### E. Run the Example App

To validate runtime behavior of the widget:

```bash
cd example
flutter pub get
flutter run -d <device-id>
```

Use `flutter devices` to list available devices.
If none exist, start an emulator (`flutter emulators`) or connect a physical device.

## 5. Continuous Integration

The repository includes GitHub workflows under `.github/workflows/`.
These typically perform:
- `flutter pub get`
- `flutter analyze`
- `flutter test`

Agents should replicate these steps locally before proposing changes.
Any change that fails CI should be corrected before issuing a pull request.

## 6. Project Layout & Architectural Notes

- **Library source:** All production code is under `lib/`. Any feature or bugfix must be implemented here.

- **Public API:** Changing widgets, constructors, exported types, or behavior requires updating both `README.md` and `CHANGELOG.md`.

- **Example app:** Located in `example/`. Use this to manually test UI interactions and dropdown behavior.

- **Tests:** Located in `test/`. Add or update tests when modifying behavior.

- **Configuration files:**
  - `pubspec.yaml` — package metadata, dependencies, SDK constraints
  - `analysis_options.yaml` (if present) — static analysis rules
  - GitHub workflow files — define CI pipeline

## 7. Common Issues & Required Precautions

- Always run `flutter pub get` in both project root and `example/` before builds.

- **SDK mismatches:** If dependency resolution fails, ensure you're using Flutter 3.24.0+ (stable channel) and Dart SDK 3.5.0+, as specified in `pubspec.yaml` (sdk: ">=3.5.0 <4.0.0"). The CI uses Flutter 3.24.0 with Dart 3.5.0.

- **Running example app:** Requires an emulator or device; `flutter run` fails if none are available.

- **Formatting and analysis errors:** Must be fixed before submitting changes.

- **Behavior changes:** If modifying dropdown behavior or object serialization, confirm that the example app still works correctly.

## 8. Pre-PR Validation Checklist

Agents should validate all of the following before creating a pull request:

- [ ] `flutter pub get` runs without errors in both project root and `example/` directory.
- [ ] Code formatting passes: `flutter format --set-exit-if-changed .`
- [ ] Static analysis passes: `flutter analyze`
- [ ] All tests pass: `flutter test`
- [ ] Example app runs successfully and demonstrates correct widget behavior.
- [ ] Package passes publishing checks: `flutter pub publish --dry-run`
- [ ] If public API changed: update `README.md` and `CHANGELOG.md`.

## 9. Trust & Search Policy

Agents should first trust these instructions for all build, test, and run steps.
Search the repository structure only when:

- A command produces an unexpected or undocumented error, or
- A referenced file is missing or differs significantly.

When searching, examine files in this priority order:
`pubspec.yaml` → `.github/workflows/` → `lib/` → `example/` → `test/` → root-level docs.

---

This concludes the repository's onboarding instructions.

# dockwalker

Dockwalker is a smart job portal that seamlessly connects candidates and employers

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# 🚀 Flutter iOS App Deployment to TestFlight

This guide explains how to build, sign, and upload your Flutter iOS app to **TestFlight** for internal and external testing.

---

## 🧩 Prerequisites

Before you begin, make sure you have:

- ✅ macOS (latest version)
- ✅ Xcode (latest version)
- ✅ Flutter SDK installed
- ✅ Valid Apple Developer Account (Paid)
- ✅ Flutter project runs correctly on iOS simulator

---

## ⚙️ Step 1: Build iOS App in Release Mode

Run the following commands in your Flutter project directory:

```bash
flutter clean
flutter pub get
flutter build ios --release

# MatchTCG Flutter App - Makefile
# Useful commands for development

.PHONY: help install clean test analyze build run-web run-android run-ios gen l10n deps upgrade format lint check

# Default target
help:
	@echo "MatchTCG Flutter App - Available Commands:"
	@echo ""
	@echo "Setup & Dependencies:"
	@echo "  install     - Install dependencies and generate code"
	@echo "  deps        - Get Flutter dependencies"
	@echo "  upgrade     - Upgrade Flutter dependencies"
	@echo "  clean       - Clean build artifacts"
	@echo ""
	@echo "Development:"
	@echo "  run-web     - Run app in Chrome (port 8080)"
	@echo "  run-android - Run app on Android device/emulator"
	@echo "  run-ios     - Run app on iOS device/simulator"
	@echo "  run-debug   - Run app in debug mode"
	@echo ""
	@echo "Code Generation:"
	@echo "  gen         - Generate code (JSON, Riverpod, etc.)"
	@echo "  l10n        - Generate localization files"
	@echo ""
	@echo "Quality Assurance:"
	@echo "  test        - Run all tests"
	@echo "  test-watch  - Run tests in watch mode"
	@echo "  analyze     - Run static analysis"
	@echo "  format      - Format code"
	@echo "  lint        - Run linter"
	@echo "  check       - Run full quality check (format + analyze + test)"
	@echo ""
	@echo "Build:"
	@echo "  build-web   - Build for web"
	@echo "  build-android - Build Android APK"
	@echo "  build-ios   - Build iOS app"
	@echo "  build-all   - Build for all platforms"

# Setup & Dependencies
install: deps gen l10n

deps:
	@echo "📦 Getting Flutter dependencies..."
	flutter pub get

upgrade:
	@echo "⬆️ Upgrading Flutter dependencies..."
	flutter pub upgrade

clean:
	@echo "🧹 Cleaning build artifacts..."
	flutter clean
	flutter pub get

# Development - Run Commands
run-web:
	@echo "🌐 Running app in Chrome on port 8085..."
	flutter run --debug -d chrome --web-port 8085

run-android:
	@echo "🤖 Running app on Android..."
	flutter run --debug -d android

run-ios:
	@echo "🍎 Running app on iOS..."
	flutter run --debug -d ios

run-debug:
	@echo "🐛 Running app in debug mode..."
	flutter run --debug

# Code Generation
gen:
	@echo "⚙️ Generating code..."
	flutter packages pub run build_runner build --delete-conflicting-outputs

gen-watch:
	@echo "👀 Watching for code generation..."
	flutter packages pub run build_runner watch --delete-conflicting-outputs

l10n:
	@echo "🌍 Generating localization files..."
	flutter gen-l10n

# Quality Assurance
test:
	@echo "🧪 Running tests..."
	flutter test --dart-define=FLUTTER_TEST=true

test-watch:
	@echo "👀 Running tests in watch mode..."
	flutter test --dart-define=FLUTTER_TEST=true --watch

test-coverage:
	@echo "📊 Running tests with coverage..."
	flutter test --dart-define=FLUTTER_TEST=true --coverage
	genhtml coverage/lcov.info -o coverage/html

analyze:
	@echo "🔍 Running static analysis..."
	flutter analyze --no-fatal-infos

format:
	@echo "✨ Formatting code..."
	dart format lib/ test/ --set-exit-if-changed

format-fix:
	@echo "🔧 Fixing code formatting..."
	dart format lib/ test/

lint:
	@echo "🔎 Running linter..."
	flutter analyze

check: format analyze test
	@echo "✅ All quality checks passed!"

# Build Commands
build-web:
	@echo "🌐 Building for web..."
	flutter build web --release

build-android:
	@echo "🤖 Building Android APK..."
	flutter build apk --release

build-android-bundle:
	@echo "🤖 Building Android App Bundle..."
	flutter build appbundle --release

build-ios:
	@echo "🍎 Building iOS app..."
	flutter build ios --release

build-all: build-web build-android build-ios
	@echo "🚀 Built for all platforms!"

# Utility Commands
devices:
	@echo "📱 Available devices:"
	flutter devices

doctor:
	@echo "🩺 Flutter doctor:"
	flutter doctor -v

outdated:
	@echo "📋 Checking for outdated packages..."
	flutter pub outdated

# Development Shortcuts
dev: clean install
	@echo "🚀 Development environment ready!"

quick-check: analyze test
	@echo "⚡ Quick quality check complete!"

# Release Commands
release-web: clean build-web
	@echo "🌐 Web release build complete!"

release-android: clean build-android-bundle
	@echo "🤖 Android release build complete!"

release-ios: clean build-ios
	@echo "🍎 iOS release build complete!"

# Git Hooks (optional)
pre-commit: format analyze
	@echo "✅ Pre-commit checks passed!"

# Docker Commands (if using Docker)
docker-build:
	@echo "🐳 Building Docker image..."
	docker build -t matchtcg-app .

docker-run:
	@echo "🐳 Running Docker container..."
	docker run -p 8080:8080 matchtcg-app

# Performance
profile-web:
	@echo "📊 Profiling web performance..."
	flutter run --profile -d chrome --web-port 8080

profile-android:
	@echo "📊 Profiling Android performance..."
	flutter run --profile -d android

# Debugging
debug-info:
	@echo "🐛 Debug information:"
	@echo "Flutter version: $$(flutter --version | head -1)"
	@echo "Dart version: $$(dart --version)"
	@echo "Current directory: $$(pwd)"
	@echo "Git branch: $$(git branch --show-current 2>/dev/null || echo 'Not a git repository')"

# Clean everything (nuclear option)
nuke: clean
	@echo "💥 Nuclear clean - removing all generated files..."
	rm -rf .dart_tool/
	rm -rf build/
	rm -rf .flutter-plugins
	rm -rf .flutter-plugins-dependencies
	rm -rf .packages
	flutter pub get
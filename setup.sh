#!/bin/bash
# shellcheck disable=SC2046
# shellcheck disable=SC2006
cd `dirname "$0"` || exit 1

# shellcheck disable=SC1035
if !(type "brew" > /dev/null 2>&1); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || exit 1
fi
# shellcheck disable=SC1035
if !(type "flutter" > /dev/null 2>&1); then
  brew install flutter || exit 1
fi

## get pub libraries
flutter clean
flutter pub get

## generate drift *.g.dart
flutter pub run build_runner build --delete-conflicting-outputs

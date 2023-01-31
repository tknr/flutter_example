#!/bin/bash
cd `dirname $0`

if !(type "brew" > /dev/null 2>&1); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if !(type "flutter" > /dev/null 2>&1); then
  brew install flutter
fi

flutter clean
flutter pub get

## generate drift *.g.dart
flutter pub run build_runner build --delete-conflicting-outputs

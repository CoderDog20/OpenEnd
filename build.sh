#!/bin/zsh
set -eu
cd "${0:A:h}"
APP="$PWD/Ollama OpenEnd.app"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
swiftc -O -parse-as-library -target arm64-apple-macosx13.0 \
  Sources/ChatHost.swift \
  -o "$APP/Contents/MacOS/LocalChat" \
  -framework Cocoa -framework WebKit -framework CryptoKit
cat > "$APP/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleExecutable</key><string>LocalChat</string>
<key>CFBundleIdentifier</key><string>local.openend.app</string>
<key>CFBundleName</key><string>Ollama OpenEnd</string>
<key>CFBundleDisplayName</key><string>Ollama OpenEnd</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>1.2</string>
<key>CFBundleVersion</key><string>1.2</string>
<key>CFBundleIconFile</key><string>LocalChat.icns</string>
<key>LSMinimumSystemVersion</key><string>13.0</string>
<key>NSHighResolutionCapable</key><true/>
<key>NSAppTransportSecurity</key><dict><key>NSAllowsLocalNetworking</key><true/></dict>
</dict></plist>
PLIST
printf 'APPL????' > "$APP/Contents/PkgInfo"
# Resources used by ChatHost.swift and the HTML UI
for f in LocalChat.icns index.html openend-corner-logo.png openend-app-icon.png logo-original.png openend-logo.png; do
  if [[ -f "Resources/$f" ]]; then
    cp "Resources/$f" "$APP/Contents/Resources/"
  fi
done
# Keep a copy of the Swift source in the bundle, matching the original app layout
cp Sources/ChatHost.swift "$APP/Contents/Resources/ChatHost.swift"
xattr -cr "$APP"
if ! codesign --force --deep --sign - "$APP"; then
  xattr -cr "$APP"
  codesign --force --deep --sign - "$APP"
fi
echo "Built $APP"

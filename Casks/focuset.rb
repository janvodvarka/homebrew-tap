cask "focuset" do
  version "0.11.2"
  sha256 "08d8b9718fd290ea28272dbb1256415e72cbc537de77f6690229e5b3a644ad7b"

  url "https://github.com/janvodvarka/focuset-releases/releases/download/v#{version}/Focuset.dmg"
  name "Focuset"
  desc "Keep the windows for one task in focus and blur the rest"
  homepage "https://focuset-landing.vercel.app/"

  livecheck do
    url "https://raw.githubusercontent.com/janvodvarka/focuset-releases/main/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Focuset.app"

  # Not notarized yet: clear the quarantine flag so the first launch doesn't hit Gatekeeper
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Focuset.app"]
  end

  zap trash: [
    "~/Library/Caches/app.focuset.mac",
    "~/Library/HTTPStorages/app.focuset.mac",
    "~/Library/Preferences/app.focuset.mac.plist",
    "~/Library/Saved Application State/app.focuset.mac.savedState",
  ]
end

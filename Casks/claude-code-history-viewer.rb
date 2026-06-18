cask "claude-code-history-viewer" do
  version "1.13.2"
  sha256 "91a7149d100dfd50811edfbeffcc87d7fef7e4e74fe10550bc50d932b17fe7a4"

  url "https://github.com/rxg9527/claude-code-history-viewer/releases/download/v1.13.2/Claude.Code.History.Viewer_1.13.1_universal.dmg"
  name "Claude Code History Viewer"
  desc "Unified history viewer for AI coding assistants"
  homepage "https://github.com/rxg9527/claude-code-history-viewer"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  app "Claude Code History Viewer.app"

  uninstall quit: "com.claude.history-viewer"

  zap trash: [
    "~/Library/Application Support/com.claude.history-viewer",
    "~/Library/Caches/com.claude.history-viewer",
    "~/Library/Preferences/com.claude.history-viewer.plist",
    "~/Library/Saved Application State/com.claude.history-viewer.savedState",
  ]

  caveats <<~EOS
    macOS builds from this fork are ad-hoc signed and not notarized. On first launch,
    open the app with right-click > Open or allow it in System Settings > Privacy & Security.
  EOS
end

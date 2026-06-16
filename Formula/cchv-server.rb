require "open-uri"

class CchvServer < Formula
  desc "Headless WebUI server for Claude Code History Viewer"
  homepage "https://github.com/rxg9527/claude-code-history-viewer"
  version "1.13.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rxg9527/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-arm64.tar.gz"
      sha256 "PLACEHOLDER_MACOS_ARM64"
    else
      url "https://github.com/rxg9527/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-x64.tar.gz"
      sha256 "PLACEHOLDER_MACOS_X64"
    end
  end

  on_linux do
    if Hardware::CPU.arm? || Hardware::CPU.arch == :arm64
      url "https://github.com/rxg9527/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-arm64.tar.gz"
      sha256 "PLACEHOLDER_LINUX_ARM64"
    else
      url "https://github.com/rxg9527/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-x64.tar.gz"
      sha256 "PLACEHOLDER_LINUX_X64"
    end
  end

  def install
    bin.install "cchv-server"
  end

  test do
    port = free_port
    pid = fork do
      exec bin/"cchv-server", "--serve", "--host", "127.0.0.1", "--port", port.to_s, "--no-auth"
    end

    sleep 3
    assert_match "\"status\":\"ok\"", URI.open("http://127.0.0.1:#{port}/health").read
  ensure
    Process.kill("TERM", pid) if pid
    Process.wait(pid) if pid
  end
end

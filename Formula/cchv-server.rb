require "open-uri"

class CchvServer < Formula
  desc "Headless WebUI server for Claude Code History Viewer"
  homepage "https://github.com/rxg9527/claude-code-history-viewer"
  version "1.13.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rxg9527/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-arm64.tar.gz"
      sha256 "7814fe996caa3a853e49339c85b1ee718354c71fbaeea6a63ea514a11bf8f920"
    else
      url "https://github.com/rxg9527/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-x64.tar.gz"
      sha256 "337c66f246da5c63c221950b93dd6dd0b603d07f10d9c9835162e65dd7bce532"
    end
  end

  on_linux do
    if Hardware::CPU.arm? || Hardware::CPU.arch == :arm64
      url "https://github.com/rxg9527/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-arm64.tar.gz"
      sha256 "1bb9dda4fc25e6b2db0e4b4c5dd0587945c79702cf2d6e4688dab7566f0e6c40"
    else
      url "https://github.com/rxg9527/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-x64.tar.gz"
      sha256 "c865dc8c1447d41f75ead010fb7697a483527f1751c44114c19236ca33a41d26"
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

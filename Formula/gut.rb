# Homebrew formula for gut
# AI-native development workflow

class Gut < Formula
  desc "AI-native development workflow for the terminal"
  homepage "https://github.com/marcelxv/gut-cli"
  url "https://github.com/marcelxv/gut-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"
  head "https://github.com/marcelxv/gut-cli.git", branch: "main"

  depends_on "bash" => "4.0"

  def install
    bin.install "gut"
  end

  test do
    assert_match "gut v#{version}", shell_output("#{bin}/gut version")
  end
end

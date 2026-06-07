# Homebrew formula for Relix — https://github.com/darkcollective/relix
#
# This file is a bootstrap template. Copy it to Formula/relix.rb in the
# darkcollective/homebrew-relix tap repository before publishing the first
# release. Subsequent releases are updated automatically by the release
# workflow; do not edit by hand after that point.
#
# Install: brew tap darkcollective/relix && brew install relix
# Upgrade: brew upgrade relix

class Relix < Formula
  desc "Relational algebra engine for .relix scripts"
  homepage "https://github.com/darkcollective/relix"
  version "0.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/darkcollective/relix/releases/download/v#{version}/relix-macos-aarch64.tar.gz"
      sha256 "10885377c461f1d057b34c2c50f757ec640994aa9004f3132bbf6c84854367da"
    end
    on_intel do
      url "https://github.com/darkcollective/relix/releases/download/v#{version}/relix-macos-x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    url "https://github.com/darkcollective/relix/releases/download/v#{version}/relix-linux-x86_64.tar.gz"
    sha256 "803a578009bfd19a5cc275707868f91f16c597ae5d0d9b2f4e43892b083a65ef"
  end

  def install
    libexec.install Dir["*"]
    bin.write_exec_script "#{libexec}/bin/relix"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/relix --version")
  end
end

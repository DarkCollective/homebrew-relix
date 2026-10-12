# The relix formula. The release workflow of DarkCollective/relix-cli writes it from
# packaging/homebrew/relix.rb there, with the release's version and checksums: change it
# there, since a change made in the tap is overwritten by the next release.
class Relix < Formula
  desc "Run Relix relational-algebra scripts as a stage of a Unix pipeline"
  homepage "https://github.com/DarkCollective/relix-cli"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/DarkCollective/relix-cli/releases/download/v#{version}/relix-#{version}-macos-aarch64.tar.gz"
      sha256 "0eea085244269e3580c9ff72e0b4b3c12e000f604f3aaacb66f96ccced37283c"
    end
    on_intel do
      url "https://github.com/DarkCollective/relix-cli/releases/download/v#{version}/relix-#{version}-macos-x86_64.tar.gz"
      sha256 "121047aef13cd54c658f3d8a4f55e9d7b5d6c2372826d771eebd13ce6d0358e2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DarkCollective/relix-cli/releases/download/v#{version}/relix-#{version}-linux-aarch64.tar.gz"
      sha256 "e309948013c48fd22ae5ba8d4dc92760caad1bcf0f3e4f1aee10884c0392b2a7"
    end
    on_intel do
      url "https://github.com/DarkCollective/relix-cli/releases/download/v#{version}/relix-#{version}-linux-x86_64.tar.gz"
      sha256 "060a9ce318f4383b6fe8ff66e304b8eb46d77f8f10c0122bf8bcde6aa074511b"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/relix"
    man1.install Dir[libexec/"man/man1/*.1"]
    bash_completion.install libexec/"completions/relix.bash" => "relix"
    zsh_completion.install libexec/"completions/_relix"
    fish_completion.install libexec/"completions/relix.fish"
  end

  test do
    (testpath/"people.csv").write "id,name\n1,ada\n2,bob\n"
    output = pipe_output("#{bin}/relix -i People=csv:people.csv", "query { SELECT id > 1 (People) };\n")
    assert_equal "id\tname\n2\tbob\n", output
  end
end

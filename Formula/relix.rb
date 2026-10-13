# The relix formula. The release workflow of DarkCollective/relix-cli writes it from
# packaging/homebrew/relix.rb there, with the release's version and checksums: change it
# there, since a change made in the tap is overwritten by the next release.
class Relix < Formula
  desc "Run Relix relational-algebra scripts as a stage of a Unix pipeline"
  homepage "https://github.com/DarkCollective/relix-cli"
  version "0.1.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/DarkCollective/relix-cli/releases/download/v#{version}/relix-#{version}-macos-aarch64.tar.gz"
      sha256 "b12119ab59e7026bc4b88746f610be42e1537b36d0df48457d7ffbce59d3a46f"
    end
    on_intel do
      url "https://github.com/DarkCollective/relix-cli/releases/download/v#{version}/relix-#{version}-macos-x86_64.tar.gz"
      sha256 "107042d6a58f593225a10f442e797bee96a4d2cfe39deace5bc16604a9c4d762"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/DarkCollective/relix-cli/releases/download/v#{version}/relix-#{version}-linux-aarch64.tar.gz"
      sha256 "d8904af44d474762884227239e5701c9429ec5afb7aa8b8d01f16a164342229c"
    end
    on_intel do
      url "https://github.com/DarkCollective/relix-cli/releases/download/v#{version}/relix-#{version}-linux-x86_64.tar.gz"
      sha256 "92f1361a9110c5fb3ae3d42e51314bf0ae10da832c8e4c428f83fbb4f61608c0"
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

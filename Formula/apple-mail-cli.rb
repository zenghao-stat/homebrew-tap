class AppleMailCli < Formula
  desc "Read and safely manage Apple Mail from the command-line"
  homepage "https://github.com/zenghao-stat/apple-mail-cli"
  url "https://github.com/zenghao-stat/apple-mail-cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "d7a3f8aff32d64eaba5f1b416e005a8620f04d138748dec75dd1d337f30af8aa"
  license "MIT"

  depends_on "swift" => :build
  depends_on :macos

  on_macos do
    depends_on macos: :sonoma
  end

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release"
    bin.install ".build/release/apple-mail-cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/apple-mail-cli --version")
    output = shell_output("#{bin}/apple-mail-cli read invalid --all-accounts 2>&1", 2)
    assert_match '"code" : "invalid_reference"', output
  end
end

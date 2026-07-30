class AppleMailCli < Formula
  desc "Read Apple Mail accounts and messages from the command-line"
  homepage "https://github.com/zenghao-stat/apple-mail-cli"
  url "https://github.com/zenghao-stat/apple-mail-cli/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "e325c26382a3e519ed155253e933e2b899edb2c72da4cb045e8781f377c13214"
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

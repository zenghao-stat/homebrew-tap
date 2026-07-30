class AppleMailCli < Formula
  desc "Read Apple Mail accounts and messages from the command-line"
  homepage "https://github.com/zenghao-stat/apple-mail-cli"
  url "https://github.com/zenghao-stat/apple-mail-cli/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "4496df2ae1993382619de1c26610b2322963243a93230ef53901a091f9e8b37d"
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

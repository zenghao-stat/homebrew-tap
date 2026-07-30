class AppleMailCli < Formula
  desc "Read Apple Mail accounts and messages from the command-line"
  homepage "https://github.com/zenghao-stat/apple-mail-cli"
  url "https://github.com/zenghao-stat/apple-mail-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0f6c2a4703b637d092dfb698b15eae6a4e33004cbbc76c46427c93d238ab1c9a"
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

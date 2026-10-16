class Emu198xSordM5 < Formula
  desc "Sord M5 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489A"
  homepage "https://emu198x.github.io/"
  version "0.34.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-sord-m5-aarch64-apple-darwin.tar.gz"
      sha256 "37fd6a509851dbc4a83bffcf3e163b126f12f4724b3f862941eeb77a9af8fd99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-sord-m5-x86_64-apple-darwin.tar.gz"
      sha256 "495f0a589e400f0f750fa51ebca232b4432478a128fc79b8248fcbdc0c1da88a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-sord-m5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "19bc5b7933bfb9c5ec2efdf9ccda53a55bac9920b1ebff4b7de0e5ed94713a40"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-sord-m5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "425f925ac48cdd03cc23cf0999e0da68f8f0407e034c8da036d63ef758738fbb"
    end
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "emu198x-sord-m5"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sord-m5"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sord-m5"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sord-m5"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

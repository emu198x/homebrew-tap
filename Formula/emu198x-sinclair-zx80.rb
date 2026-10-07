class Emu198xSinclairZx80 < Formula
  desc "Sinclair ZX80 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sinclair-zx80-aarch64-apple-darwin.tar.gz"
      sha256 "3f9bb27b55a548cb443d34dc2d9239c88e2a21987d76f4ad2e93a8a0041fd1f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sinclair-zx80-x86_64-apple-darwin.tar.gz"
      sha256 "df00f34b5317af1401463b5e12071cfcb35f6a3195c1e47f76dffd9a3a1ea539"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sinclair-zx80-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6e6a88d5a7c61ec73890df360b02d623129c0beff3ad8c1949717522935dcc19"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sinclair-zx80-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "15da47dc7048c4cee814d05edd2ffceb57af135c70f6720be6fe955535c73f41"
    end
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "emu198x-sinclair-zx80"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sinclair-zx80"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sinclair-zx80"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sinclair-zx80"
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

class Emu198xSinclairZx81 < Formula
  desc "Sinclair ZX81 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sinclair-zx81-aarch64-apple-darwin.tar.gz"
      sha256 "ad818749d81e352294b22b564b80721c9173a9e01d1168712d27303a065b04a0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sinclair-zx81-x86_64-apple-darwin.tar.gz"
      sha256 "08cfaa7a1fa9b3a7c955a2c5e33d53fe5c00be3b57e48dc4f04fc9f60b277a73"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sinclair-zx81-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ba4d7251f61dc5689136ac1334084ad0c05ed2eae17500f454efd441fadbbb99"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sinclair-zx81-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f13294ae1b3e92ee9fb807335345dafd033595bb14a4590d5551ed985e06fd89"
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
      bin.install "emu198x-sinclair-zx81"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sinclair-zx81"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sinclair-zx81"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sinclair-zx81"
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

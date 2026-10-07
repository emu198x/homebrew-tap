class Emu198xAtari5200 < Formula
  desc "Atari 5200 SuperSystem headless runner with shell-backed script + MCP parity — 6502 + ANTIC + GTIA + POKEY"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-5200-aarch64-apple-darwin.tar.gz"
      sha256 "131d3f0e504347467107dd1664d72637b73285f760aeb90bc47b120308bc8e88"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-5200-x86_64-apple-darwin.tar.gz"
      sha256 "64221a41af390c4bbb9258f0ed4415eebc224e335d35ad2fa48db4536831aadd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-5200-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7a68ac99edcb7c865049a0c15a8ce2d0d03376f6252830f3abf38242c45e4cb2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-5200-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6d16f0e7d7e27f8f50d78bd5325c91620bd3ef0f74f38cbb1120f3e3ac78e1ec"
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
      bin.install "emu198x-atari-5200"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-5200"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-5200"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-5200"
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

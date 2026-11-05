class Emu198xAtari5200 < Formula
  desc "Atari 5200 SuperSystem headless runner with shell-backed script + MCP parity — 6502 + ANTIC + GTIA + POKEY"
  homepage "https://emu198x.github.io/"
  version "0.48.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.1/emu198x-atari-5200-aarch64-apple-darwin.tar.gz"
      sha256 "02151f4a3d66059d001fdf8f33ba5ee2c20d36334978f7b2e495d0b72ffef15a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.1/emu198x-atari-5200-x86_64-apple-darwin.tar.gz"
      sha256 "5aa14d47ffbd85ffd0fca442af41980f52975f2c92757cbea386d25fc89a9901"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.1/emu198x-atari-5200-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bd3f71f6a8def3c15c5fda256f1702f67263916b72304bb6999c6d010c4ddbd5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.1/emu198x-atari-5200-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "93a0a7b06ffe41e14cc2ef6bdcaf68171dd44664167f279ed5d743005f58ab56"
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

class Emu198xAtari5200 < Formula
  desc "Atari 5200 SuperSystem headless runner with shell-backed script + MCP parity — 6502 + ANTIC + GTIA + POKEY"
  homepage "https://emu198x.github.io/"
  version "0.32.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-atari-5200-aarch64-apple-darwin.tar.gz"
      sha256 "d939fc1ffb36b519316dc193a7e357912c3a9fc808b33ee7df8f657dbbd0e7cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-atari-5200-x86_64-apple-darwin.tar.gz"
      sha256 "dbbb3550f466f2c5f51e64eec1cc3c7a77ab934a8d89169396893900fb153d99"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-atari-5200-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "90890dabcb02f54d4002d0367020e41526f8d7ad00ebc49bd5858c72c66fd583"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-atari-5200-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "299f6acd78a81f7d6f13e2a9504e08a7891467d0f41896a65563833520b885ff"
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

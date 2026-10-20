class Emu198xAtari2600 < Formula
  desc "Atari 2600 (VCS) headless runner with shell-backed script + MCP parity — 6507 + TIA + RIOT"
  homepage "https://emu198x.github.io/"
  version "0.39.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-atari-2600-aarch64-apple-darwin.tar.gz"
      sha256 "5ea27b0def7a0ce87efa8d500843e6e2abf21a3f20f2414f3a33d9abe6839f69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-atari-2600-x86_64-apple-darwin.tar.gz"
      sha256 "7cf1a7252418635a40f0f4a19340f270e5f5e667d7f8429a2073870b71b4a6ff"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-atari-2600-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d9326024c118a98d18ed09dd939515afbfba6296baeaf86e2650b9995682895e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-atari-2600-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7d776a5d49517fcf799d26d52a59f9a93ad116e3c7baa9b753b1db80a63c66fa"
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
      bin.install "emu198x-atari-2600"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-2600"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-2600"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-2600"
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

class Emu198xAtari7800 < Formula
  desc "Atari 7800 ProSystem headless runner with shell-backed script + MCP parity — 6502C Sally + MARIA + RIOT"
  homepage "https://emu198x.github.io/"
  version "0.37.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-atari-7800-aarch64-apple-darwin.tar.gz"
      sha256 "318433bce5956795ea7a0a241d1fda416cc00a6c58d653bb0909b1c6d36c1047"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-atari-7800-x86_64-apple-darwin.tar.gz"
      sha256 "856b7075db6bff5e6825a38883c7710dc912b589b4e00f87c71834ced3771394"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-atari-7800-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ee0c6ee1598e2b08e23a9228d1dbd49835ffa08c4987cea40bce5df2fb5f20fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-atari-7800-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "73c7240d04b69e7a5cc51a35247946e80ec78b1b9e4f874425a4537025d6613a"
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
      bin.install "emu198x-atari-7800"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-7800"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-7800"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-7800"
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

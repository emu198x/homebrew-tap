class Emu198xAppleIi < Formula
  desc "Original Apple II emulator with shared native UI, scripts and MCP"
  homepage "https://emu198x.github.io/"
  version "0.48.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.1/emu198x-apple-ii-aarch64-apple-darwin.tar.gz"
      sha256 "175588b23f2725c4a728798181a83262142a6b59085ac8e123cda86108d98fbb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.1/emu198x-apple-ii-x86_64-apple-darwin.tar.gz"
      sha256 "4af4413620e374c8108009b107ea9c39d564677259909ca56b587d31163b79ce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.1/emu198x-apple-ii-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c76dde9aa2005da2836231aa36450ca1d2debcf58e28bab114951a07c97ff6b7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.1/emu198x-apple-ii-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "94e3d7396b8c6a0aef288fba54ebf5a45eced0d929690a8c17c28b7a0d11e3b0"
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
      bin.install "emu198x-apple-ii"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-apple-ii"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-apple-ii"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-apple-ii"
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

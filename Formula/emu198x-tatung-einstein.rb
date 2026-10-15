class Emu198xTatungEinstein < Formula
  desc "Tatung Einstein TC-01 headless runner with shell-backed script + MCP parity — Z80 + TMS9929A + AY-3-8910"
  homepage "https://emu198x.github.io/"
  version "0.34.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-tatung-einstein-aarch64-apple-darwin.tar.gz"
      sha256 "5087c5166c81a7d60cfb82781a7b5ed94c145efbe05db08570b989f54aaa9921"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-tatung-einstein-x86_64-apple-darwin.tar.gz"
      sha256 "aa0b68741fb03ee8e72bf07a9c4d306b9a3e5d3114b4ab479f3b67c4036158f2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-tatung-einstein-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "006bfc0af1df052b1c38f6ccfd625180ea9f5c504c832e795ba52a5a6481ce1c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-tatung-einstein-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7069f661d0ead32611b4c3526cc6e64463f323d4bfcdb920acb46ac2c1f83083"
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
      bin.install "emu198x-tatung-einstein"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-tatung-einstein"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-tatung-einstein"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-tatung-einstein"
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

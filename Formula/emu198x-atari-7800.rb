class Emu198xAtari7800 < Formula
  desc "Atari 7800 ProSystem headless runner with shell-backed script + MCP parity — 6502C Sally + MARIA + RIOT"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-7800-aarch64-apple-darwin.tar.gz"
      sha256 "3e50ad860940f8b3eb68603db0e1914eb330b4fc379f4d8a3d1b3dc172dc1d12"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-7800-x86_64-apple-darwin.tar.gz"
      sha256 "7aa826298f33240ebe43458a97b8f1a7cdc063e6e9f8c36f22f288de69cb14dd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-7800-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1f0565183588de2014e8597623edcb2f8027d21f73d64093fd059bae5ab027d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-7800-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0ca62a4d1612c69f7ac398e4a6de537613aa591da7030b2ff8f751888a58d9eb"
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

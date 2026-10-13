class Emu198xMemotechMtx < Formula
  desc "Memotech MTX headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.32.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-memotech-mtx-aarch64-apple-darwin.tar.gz"
      sha256 "c49386f69786baa1f3af14779e6b8a41b50d14bc241743fa4bd5aa31f5fb3b12"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-memotech-mtx-x86_64-apple-darwin.tar.gz"
      sha256 "97f3efbeda6dd48490bdac1f09420c4535f64b8418193ff22803ff715d6bb28e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-memotech-mtx-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8d65364084800ae3332301ad4ec2a3eccb32ea808b465043042e7015c9ffe4ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-memotech-mtx-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2bf733c88699a7185d26bd5598a4231b50850ef09f9aa31da21a92090c8f1cca"
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
      bin.install "emu198x-memotech-mtx"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-memotech-mtx"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-memotech-mtx"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-memotech-mtx"
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

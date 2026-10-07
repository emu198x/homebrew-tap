class Emu198xMemotechMtx < Formula
  desc "Memotech MTX headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-memotech-mtx-aarch64-apple-darwin.tar.gz"
      sha256 "5009226b24a64f8c060eee2abc6775fcc41d78ecc961f0a82cda2fce8ba86936"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-memotech-mtx-x86_64-apple-darwin.tar.gz"
      sha256 "49f0201a062743373f51f10eae50fe0f251cd236a45ccd89eafc773ff02adb49"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-memotech-mtx-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c8f320af2c74fe0b4cc6c7436d1334f011e3e9ea338c5fd10e1f0ae15d6ebb57"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-memotech-mtx-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "745440f15e0c4be95bd78c00b1601467c9788082914c7c909154ca7cff157c0f"
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

class Emu198xNes < Formula
  desc "Native NES verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.39.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-nes-aarch64-apple-darwin.tar.gz"
      sha256 "9d0f63c1937cfe5f317287c63478e3992da71a7a4c8821b7212f9b343e6bcd8f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-nes-x86_64-apple-darwin.tar.gz"
      sha256 "06911d70d23dbb383b1a899dc865c58d2a06fa6f89964b9b1e1edb71df0f94c2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-nes-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b4bc190f3febce747cdadb8ac575d2dd5af27cbe4b3ac9805aa059945105b77d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-nes-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cb496e972e915849e2153ff222ca045810a1b7ff214a76264390f3eeeb3c072c"
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
      bin.install "emu198x-nes"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-nes"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-nes"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-nes"
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

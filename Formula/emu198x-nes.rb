class Emu198xNes < Formula
  desc "Native NES verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-nes-aarch64-apple-darwin.tar.gz"
      sha256 "1c9a31c9c0267a8619c53ee1db490f2b78cff6ddfe4d5a67091780b7e11993b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-nes-x86_64-apple-darwin.tar.gz"
      sha256 "667a047e36577debbb874d3757544dc9746a3ce63c43174754acef339ae00dcd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-nes-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c4a8a0ca363262b2a960a7dc13f6af9b921ce7c8000ff4b2ea7606aa8a226e3c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-nes-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7414627b80cb46883bb7ab774ce78064a636ea3087696c36736e8cba208c1a47"
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

class Emu198xNes < Formula
  desc "Native NES verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.35.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.4/emu198x-nes-aarch64-apple-darwin.tar.gz"
      sha256 "84b21fb9a45a518c18374c7250f152ba2f5fe4f46e8850e2a0e2852bdf287bdc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.4/emu198x-nes-x86_64-apple-darwin.tar.gz"
      sha256 "8d2aaeebb135a383775db47b93692828b281e98a91e048e29ec6bb4798852a0d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.4/emu198x-nes-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f0aba2f2e9173943236b39a1f2f50217e4c034f4ac1707337b045e8a236264bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.4/emu198x-nes-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "31ae2c51d6fa251a80830b54e42d7b861e74beb2dce31ee9097808cc7a8339f4"
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

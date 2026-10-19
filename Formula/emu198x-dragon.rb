class Emu198xDragon < Formula
  desc "Native Dragon 32/64 verifier with interactive UI, headless harness, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.38.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.2/emu198x-dragon-aarch64-apple-darwin.tar.gz"
      sha256 "560ac505775d4932277b831d4175caa2e1d7ffca97091e3e8dd1266a6f70009f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.2/emu198x-dragon-x86_64-apple-darwin.tar.gz"
      sha256 "218606afc4e08b6a4d327a80f151261e4a334188235f899dc9f879b04b1bc3ad"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.2/emu198x-dragon-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dfe06a2b6bb9172854262d3dfa403ceae399d7d09a9f374059f4d78bbc1ddadc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.2/emu198x-dragon-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "64b7a3f3430222608f6e13f46b3e76f1ef99f2b97bab53a90a465db08e424a79"
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
      bin.install "emu198x-dragon"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-dragon"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-dragon"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-dragon"
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

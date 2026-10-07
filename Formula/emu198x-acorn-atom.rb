class Emu198xAcornAtom < Formula
  desc "Acorn Atom headless runner with shell-backed script + MCP parity — 6502 + 24 KB combined ROM"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-acorn-atom-aarch64-apple-darwin.tar.gz"
      sha256 "8a16b67e955c970d4e4d4159c1cb79ebb9362650c48f25b0cc4bfd486ad9b8b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-acorn-atom-x86_64-apple-darwin.tar.gz"
      sha256 "3a636c5d3e351a591f223ab465547897a6087a2d121605a119501803ca38e4c5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-acorn-atom-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8cb1367938aed45722bed8d0ba116fc2aba4357df309bb273ad60813afda725f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-acorn-atom-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7be25a758256a37cbd32d0977a3e821b1cd722122f60b1dd461e1cc3dd1b7c2f"
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
      bin.install "emu198x-acorn-atom"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-atom"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-acorn-atom"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-atom"
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

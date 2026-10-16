class Emu198xAcornAtom < Formula
  desc "Acorn Atom headless runner with shell-backed script + MCP parity — 6502 + 24 KB combined ROM"
  homepage "https://emu198x.github.io/"
  version "0.35.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-acorn-atom-aarch64-apple-darwin.tar.gz"
      sha256 "593c33d543566542962d9aeaa4b9af5a83c0175719d62886be02cef9b4b23163"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-acorn-atom-x86_64-apple-darwin.tar.gz"
      sha256 "a66abc3cb9616f285c9a334a17e158c3600529e98148c001be8df2f76c83b34b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-acorn-atom-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bb2cfeb3f8435cc0410dea564f383f3d3b23d64be559da30bb669f8d4fcbf919"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-acorn-atom-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0c6d424de4eaaf6c442fcf434cc5d596609701cbf55a0e7700d85c7289f149aa"
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

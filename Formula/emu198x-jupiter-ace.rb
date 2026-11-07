class Emu198xJupiterAce < Formula
  desc "Jupiter Ace headless runner with shell-backed script + MCP parity — Z80A + 8 KB Forth ROM"
  homepage "https://emu198x.github.io/"
  version "0.48.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-jupiter-ace-aarch64-apple-darwin.tar.gz"
      sha256 "1e3ce33c8268b08ec8b79d042b9a9cabdae962e4fb1f62facbe06dd884e5741a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-jupiter-ace-x86_64-apple-darwin.tar.gz"
      sha256 "eff2a5248ecf4a9f08e9e8ddecd28af8d9e6e3c75ac5016838c553132065d9c3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-jupiter-ace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a0f5bce67658235bc9cc44f378919607de5ef6e782519b536fb57ad388c6a675"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-jupiter-ace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ed605699c146b5b282296a00a669a36743bcd233b1eb012f1eb2f50c5e3cf4fb"
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
      bin.install "emu198x-jupiter-ace"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-jupiter-ace"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-jupiter-ace"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-jupiter-ace"
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

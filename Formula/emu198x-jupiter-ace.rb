class Emu198xJupiterAce < Formula
  desc "Jupiter Ace headless runner with shell-backed script + MCP parity — Z80A + 8 KB Forth ROM"
  homepage "https://emu198x.github.io/"
  version "0.39.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.1/emu198x-jupiter-ace-aarch64-apple-darwin.tar.gz"
      sha256 "63bb1dd08925f01839687578bd91c2b178474f8bf71469675f8cce3f83b4fa3a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.1/emu198x-jupiter-ace-x86_64-apple-darwin.tar.gz"
      sha256 "5219cd538935b0f674f4285249bd8704d6bf98fca1e7701299f665a7101cdc00"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.1/emu198x-jupiter-ace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "84e71aabe1c58f382677c4924140cd2319876733d47b23b09675ff7f53978c51"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.1/emu198x-jupiter-ace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "87f179e2e8fbc36df05d91cf554093bfcd37dd8fcdeeacad96865f265b62d76e"
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

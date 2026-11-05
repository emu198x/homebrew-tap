class Emu198xAcornBbcMicro < Formula
  desc "BBC Micro Model B headless runner with shell-backed script + MCP parity — 6502 + 6845 + Video ULA + 2x VIA + SN76489"
  homepage "https://emu198x.github.io/"
  version "0.48.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-acorn-bbc-micro-aarch64-apple-darwin.tar.gz"
      sha256 "70c585cc43d091e5b6235133bbab571281635339060f62eb40b2a7f27daf2ec0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-acorn-bbc-micro-x86_64-apple-darwin.tar.gz"
      sha256 "5aaa404e7ea40c1e1d00617c04649f00661ecd8996cf8a07da35013de90cd59c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-acorn-bbc-micro-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "74e9d8efc5a47e2fa079bcd512ffd7d1c0cc321a53661c1b414507706101fd90"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-acorn-bbc-micro-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "928b33f7fd8a3e7bbfda87fcee69e2d57cc5c281436344ab26aab186ff865785"
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
      bin.install "emu198x-acorn-bbc-micro"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-bbc-micro"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-acorn-bbc-micro"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-bbc-micro"
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

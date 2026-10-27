class Emu198xAcornBbcMicro < Formula
  desc "BBC Micro Model B headless runner with shell-backed script + MCP parity — 6502 + 6845 + Video ULA + 2x VIA + SN76489"
  homepage "https://emu198x.github.io/"
  version "0.45.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-acorn-bbc-micro-aarch64-apple-darwin.tar.gz"
      sha256 "7efd5a1413e72bd814a41e81351ec67bc55a4e1c6be50a04d8044e7ed595b2b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-acorn-bbc-micro-x86_64-apple-darwin.tar.gz"
      sha256 "c52325ebf4a10787141b643541ac4024c893a83b3dcaaefb36a51577c540943f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-acorn-bbc-micro-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bbcc530d2ffbaecb85bff7b9953bc2a38029dbc6fb421ac431567ab8505188f9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-acorn-bbc-micro-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eb8b8f9bfe5e3459c079526517779dfea4a336652199f78a6984a4d8ec7fab75"
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

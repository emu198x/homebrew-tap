class Emu198xSnkNeoGeo < Formula
  desc "SNK Neo Geo AES headless runner with shell-backed script + MCP parity — 68000 + Z80 + LSPC2 + YM2610"
  homepage "https://emu198x.github.io/"
  version "0.48.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-snk-neo-geo-aarch64-apple-darwin.tar.gz"
      sha256 "b4eae1803f314ac79cd0bbcee143b16f60ab6f004fcdb91c8f78f5bd91143a9a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-snk-neo-geo-x86_64-apple-darwin.tar.gz"
      sha256 "cfe168ad35aa8d50cc7f953f3259fd1d33f962783e700b77e59fe2667894ceef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-snk-neo-geo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d2dc3cf49f56be93bd02ec82ad92e806bc5d7454ae92cacd18a89a72938e06c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-snk-neo-geo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3e277fd9b08de0fa8983b6b6e803e2174bd9fac650711e796707e7488c671aef"
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
      bin.install "emu198x-snk-neo-geo"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-snk-neo-geo"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-snk-neo-geo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-snk-neo-geo"
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

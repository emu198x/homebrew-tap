class Emu198xSnes < Formula
  desc "Super NES / Super Famicom headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.47.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.47.0/emu198x-snes-aarch64-apple-darwin.tar.gz"
      sha256 "1aa12c036706fa92dd6dfd9adcab98d6bffb018f801f4abaa1a084c5d6198e5c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.47.0/emu198x-snes-x86_64-apple-darwin.tar.gz"
      sha256 "7bfd3d120108aad7c20e7a029de9364527bb7c1cb3e1bd569a4a151cd32ab66b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.47.0/emu198x-snes-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d162197e9330b08db97eec38e36bfc50102cfdbf85d3aba846ab9949aa95aab5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.47.0/emu198x-snes-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "42224886a6a10c68460893a56cedff9aa7cb164dfedd93013887d225bc00d43f"
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
      bin.install "emu198x-snes"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-snes"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-snes"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-snes"
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

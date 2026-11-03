class Emu198xSegaGameGear < Formula
  desc "Sega Game Gear headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.47.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.47.0/emu198x-sega-game-gear-aarch64-apple-darwin.tar.gz"
      sha256 "86bcff5ca817fdda596583da6a75279accf7b5cac08bcae67260a2ed259a3019"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.47.0/emu198x-sega-game-gear-x86_64-apple-darwin.tar.gz"
      sha256 "fec6eeb386409ea8b43ff12b39899ae3ec94a0fd18769681ac73fe2f5f5ef19c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.47.0/emu198x-sega-game-gear-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "baf5ba22488ae41d3bc11485b1ef9aed37f4a244d4cc96df246283da02a388bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.47.0/emu198x-sega-game-gear-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "25cd10ee25ecb455991ddc0ece457aa6f9517906480ee25a7179aefc038fb8d0"
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
      bin.install "emu198x-sega-game-gear"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sega-game-gear"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sega-game-gear"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sega-game-gear"
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

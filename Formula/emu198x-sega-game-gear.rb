class Emu198xSegaGameGear < Formula
  desc "Sega Game Gear headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.42.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-sega-game-gear-aarch64-apple-darwin.tar.gz"
      sha256 "f4e099eea181f6d81d133ea11e73c1103539f15f72be97794bec6d63f3718c7f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-sega-game-gear-x86_64-apple-darwin.tar.gz"
      sha256 "42983828b981bd8838df34d0b464c6ebc6ae94b5a18fc9254b5bbc817584ce72"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-sega-game-gear-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b1b9cd1f5233e8d84a2fb4bbd99d330b981245161211548390767fa3e4622dfc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-sega-game-gear-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "34f91a354cf1cd1016f6afbe57da7acb9a660094020e8973ef28fd88cbd0e263"
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

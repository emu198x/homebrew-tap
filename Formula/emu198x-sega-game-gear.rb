class Emu198xSegaGameGear < Formula
  desc "Sega Game Gear headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.34.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-sega-game-gear-aarch64-apple-darwin.tar.gz"
      sha256 "81bea8f530cbea512f98a9cc9ced2ef678e12ace2262d35b4d1205d556a10cfb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-sega-game-gear-x86_64-apple-darwin.tar.gz"
      sha256 "38479841ce2570fe616b780a8c89969e585f11dd054641aaeee42816efa41e0a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-sega-game-gear-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "377e2a88e2c1ced9c82a7a7ff9e8f2df8f2d1048c3e2833e136e65b8c05871e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-sega-game-gear-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "78503073a5352bdc0ce171ec5ec094afea698190f39a446324f3640422686603"
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

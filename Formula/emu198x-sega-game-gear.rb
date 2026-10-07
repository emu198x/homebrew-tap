class Emu198xSegaGameGear < Formula
  desc "Sega Game Gear headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sega-game-gear-aarch64-apple-darwin.tar.gz"
      sha256 "5bc550d5d1c04c32505a267732498a55c1fa92ca918e46033d8d9beac736a871"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sega-game-gear-x86_64-apple-darwin.tar.gz"
      sha256 "166a6eb7e6003e9d733476d5bfc87a36a646325e7a501d617969c65c775efa6c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sega-game-gear-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0dcb377d388f42bddf1c7ae3fe79fca20c7586ec6e5d0cad258535206703c037"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-sega-game-gear-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "01c1e981af2f610a4f7fe627acc4f0562ffef9e5a9d5097b197df1a7f4ef4c0c"
    end
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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

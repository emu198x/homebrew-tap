class Emu198xSegaGameGear < Formula
  desc "Sega Game Gear headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.44.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-sega-game-gear-aarch64-apple-darwin.tar.gz"
      sha256 "38a8779668ad9ae20504e3903fec9bf83aabbc1288813bcb49b2e1e3a2a16435"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-sega-game-gear-x86_64-apple-darwin.tar.gz"
      sha256 "5cae85f551d3dc5124f7610647b4f84fcd9faf3572cb8785bfe121526bf8e475"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-sega-game-gear-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d955c1ea326ae2f83bc33502bf6e2c9eb8ce497db685f059a22f0aeb8ce93a1a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-sega-game-gear-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "895ac657f7020340ab219d2f498ceb9d1f58d4c354fba3fad58bbf34b1db4a08"
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

class Emu198xAtari800xl < Formula
  desc "Atari 800XL headless runner with shell-backed script + MCP parity — 6502C Sally + ANTIC + GTIA + POKEY + PIA-6520"
  homepage "https://emu198x.github.io/"
  version "0.35.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-atari-800xl-aarch64-apple-darwin.tar.gz"
      sha256 "b86041028308c1327aba5bd71dd29dc2e1fcc7cbcd7d794998a183c485a77614"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-atari-800xl-x86_64-apple-darwin.tar.gz"
      sha256 "545a118cdf763653d70a1ac23638b44af861f6409b40061d494b6a592331ad20"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-atari-800xl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6160ef4ca5a751ac108db31b486463519da39f2c28eb9969c8bd2ca777a624e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-atari-800xl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ac9a322419f5b8bc4d15c90844cfee9a0017a15594aca3942e52d7d514a6620"
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
      bin.install "emu198x-atari-800xl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-800xl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-800xl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-800xl"
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

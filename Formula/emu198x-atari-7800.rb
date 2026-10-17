class Emu198xAtari7800 < Formula
  desc "Atari 7800 ProSystem headless runner with shell-backed script + MCP parity — 6502C Sally + MARIA + RIOT"
  homepage "https://emu198x.github.io/"
  version "0.36.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.36.0/emu198x-atari-7800-aarch64-apple-darwin.tar.gz"
      sha256 "dd05185f020300cb84f9ada7f057d5764795ed2a10e2fca1cb11d66c8ad4385b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.36.0/emu198x-atari-7800-x86_64-apple-darwin.tar.gz"
      sha256 "ac665b7d912fed252236f6ba75645bd279b7a3f61be54e26e95363c1ad73df3c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.36.0/emu198x-atari-7800-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0bbdb8bcba228afce20a0b8e9911a280eddee627cb20a56dd1780d44250fedae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.36.0/emu198x-atari-7800-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "78706408ccbbaad5dda957587501c6b4c6396ab7cbdbc7b760d13bc6f2feaa85"
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
      bin.install "emu198x-atari-7800"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-7800"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-7800"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-7800"
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

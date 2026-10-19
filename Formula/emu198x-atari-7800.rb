class Emu198xAtari7800 < Formula
  desc "Atari 7800 ProSystem headless runner with shell-backed script + MCP parity — 6502C Sally + MARIA + RIOT"
  homepage "https://emu198x.github.io/"
  version "0.38.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-atari-7800-aarch64-apple-darwin.tar.gz"
      sha256 "92f2dceff81804a2a27d25259d8234a60193df013d568c4f688614bdada59ff6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-atari-7800-x86_64-apple-darwin.tar.gz"
      sha256 "e2ca75b655b432eac277ee43540eac66eb49230c41dec82b7b1a9cab335afa25"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-atari-7800-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b76514c6dc985674e2e9c0ecf4f7b3c554f85bec7c13b993464ed91a96410b6b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-atari-7800-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "54419f99a74660cd94575aed17f0d8682d2e0b078e9f61d7e372dd8a52084f6b"
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

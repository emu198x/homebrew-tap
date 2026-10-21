class Emu198xAtari5200 < Formula
  desc "Atari 5200 SuperSystem headless runner with shell-backed script + MCP parity — 6502 + ANTIC + GTIA + POKEY"
  homepage "https://emu198x.github.io/"
  version "0.43.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.43.0/emu198x-atari-5200-aarch64-apple-darwin.tar.gz"
      sha256 "847f7f68aec2784e7efb092db782fe185bae21f64e510d5c036000ebbb57a730"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.43.0/emu198x-atari-5200-x86_64-apple-darwin.tar.gz"
      sha256 "d094987ab538c37649daf28e09f4486f56fad02b7c5c95a7cb010ebb59d23c0e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.43.0/emu198x-atari-5200-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7fe60f3e3453bac21b78216db1b546d1de358cc3ed376a38d2cf0c272e83f777"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.43.0/emu198x-atari-5200-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e3f14e950699faa7824bbe63988300d5adc29b07340e75387b97d1d3bb9d12b9"
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
      bin.install "emu198x-atari-5200"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-5200"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-5200"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-5200"
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

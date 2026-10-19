class Emu198xAtari5200 < Formula
  desc "Atari 5200 SuperSystem headless runner with shell-backed script + MCP parity — 6502 + ANTIC + GTIA + POKEY"
  homepage "https://emu198x.github.io/"
  version "0.38.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-atari-5200-aarch64-apple-darwin.tar.gz"
      sha256 "534cdcbbebaef3761d2afd96029c12315936efba57abfb7a6ba08b480df30a65"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-atari-5200-x86_64-apple-darwin.tar.gz"
      sha256 "912d189a2fddaabf571c6cb82617ee920ab337cf8dc2de8bd2b7cb4ae54d3b42"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-atari-5200-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6af0a5cdab4a41284e3df55a450de7a139580cf2e02c614601595171f519c0f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-atari-5200-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "65e4d0bcc0d50587eac7e946ea5de3218a62ca193ea13a47b8185dfcf65d0cf7"
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

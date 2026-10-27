class Emu198xSnkNeoGeo < Formula
  desc "SNK Neo Geo AES headless runner with shell-backed script + MCP parity — 68000 + Z80 + LSPC2 + YM2610"
  homepage "https://emu198x.github.io/"
  version "0.45.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-snk-neo-geo-aarch64-apple-darwin.tar.gz"
      sha256 "bb963dbeed39926816c0d820f30c5f0744fce2606bb401ac58f7cb5d91189cc4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-snk-neo-geo-x86_64-apple-darwin.tar.gz"
      sha256 "622122734b9de142aaf419cdf4c9e80b1aeafac6ee28800f51dc396ae8eded0e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-snk-neo-geo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4282b7c936bf3c1d3906c2af288011ddae0de396209818e85ad8ed74f0b7e074"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-snk-neo-geo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "677e794e5a07d5e8d27f8f7b3cb68d379cd97cb6bf07edc29ce718c4034740a8"
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
      bin.install "emu198x-snk-neo-geo"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-snk-neo-geo"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-snk-neo-geo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-snk-neo-geo"
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

class Emu198xSnkNeoGeo < Formula
  desc "SNK Neo Geo AES headless runner with shell-backed script + MCP parity — 68000 + Z80 + LSPC2 + YM2610"
  homepage "https://emu198x.github.io/"
  version "0.48.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.1/emu198x-snk-neo-geo-aarch64-apple-darwin.tar.gz"
      sha256 "af76c4f30946bd5b571f9a9feb8c5ed9c94966099194bccab26af90836eb4bce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.1/emu198x-snk-neo-geo-x86_64-apple-darwin.tar.gz"
      sha256 "d5c90b3dd9fdbbd2b7d0460d82d0e4555b9ceea79d9edefacfcaa56d1c52e60c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.1/emu198x-snk-neo-geo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "742cf51b05133ab2730475266ac48df32f802af4ee2ecdd5d72f8e1b92d85411"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.1/emu198x-snk-neo-geo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0a41170d12b6a5df82453881ca9638a623b79a38464b753d6135056e6e1c1131"
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

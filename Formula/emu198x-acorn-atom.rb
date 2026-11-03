class Emu198xAcornAtom < Formula
  desc "Acorn Atom headless runner with shell-backed script + MCP parity — 6502 + 24 KB combined ROM"
  homepage "https://emu198x.github.io/"
  version "0.46.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-acorn-atom-aarch64-apple-darwin.tar.gz"
      sha256 "81e31019346c7c62167c8df7ead07381627116befb65703cbd1dd685915089a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-acorn-atom-x86_64-apple-darwin.tar.gz"
      sha256 "ed9bfc9a233de192d382097c4a96bc2ef62d3ce6409f98903f0234842a2f1457"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-acorn-atom-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "04ee471105d41f85f6218ac2e261c9552b7a8c71655e27d392fca8f63c65ea80"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-acorn-atom-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9c369b8d947dcd11d216ff9b5a5579a38d593faa0ff7da919ff75cc0b1bf80d5"
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
      bin.install "emu198x-acorn-atom"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-atom"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-acorn-atom"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-atom"
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

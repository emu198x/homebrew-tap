class Emu198xAcornElectron < Formula
  desc "Acorn Electron headless runner with shell-backed script + MCP parity — 6502A + custom ULA"
  homepage "https://emu198x.github.io/"
  version "0.32.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-acorn-electron-aarch64-apple-darwin.tar.gz"
      sha256 "004ded791cfec1d11c2d6d5bfb53a8dd77fcf2dda5949317605d89389a471144"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-acorn-electron-x86_64-apple-darwin.tar.gz"
      sha256 "1e3eed4bf15dbc108b648c16caa71e089dac8c2bb5d56867baaa030472b92ab6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-acorn-electron-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d245bae53836f785af7bbbd200639989163622128f82f45cb12ade638f90387a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-acorn-electron-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "39946d24da21daaa96c6b8280a80b4e909fd0aa50413d9cd907c8213905b632c"
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
      bin.install "emu198x-acorn-electron"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-electron"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-acorn-electron"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-electron"
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

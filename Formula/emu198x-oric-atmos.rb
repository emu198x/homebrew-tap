class Emu198xOricAtmos < Formula
  desc "Oric-1 / Atmos headless runner with shell-backed script + MCP parity — 6502 + ULA + VIA-6522 + AY-3-8910"
  homepage "https://emu198x.github.io/"
  version "0.36.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.36.0/emu198x-oric-atmos-aarch64-apple-darwin.tar.gz"
      sha256 "82172ef493316d86687129efd704c3c71d0ccf8a2275fc7ec90c1ab74c40d3b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.36.0/emu198x-oric-atmos-x86_64-apple-darwin.tar.gz"
      sha256 "e7edcfcb6d297907cc3930fef127ab8be20f0401578349b9ed68deb98ebb1310"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.36.0/emu198x-oric-atmos-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f02acc0f2452413b8525374d6158e333608203e88f2a04375b1e5ad77ddc73b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.36.0/emu198x-oric-atmos-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9cebfbb6a6bc922150329cc8ede965f384b0484bb3d6c9ede65ebe6c1a061642"
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
      bin.install "emu198x-oric-atmos"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-oric-atmos"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-oric-atmos"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-oric-atmos"
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

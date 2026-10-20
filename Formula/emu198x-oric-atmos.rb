class Emu198xOricAtmos < Formula
  desc "Oric-1 / Atmos headless runner with shell-backed script + MCP parity — 6502 + ULA + VIA-6522 + AY-3-8910"
  homepage "https://emu198x.github.io/"
  version "0.39.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.2/emu198x-oric-atmos-aarch64-apple-darwin.tar.gz"
      sha256 "a3e2bb60fd23e1ea26d44e1fa2010ddf2f4e09a8540978238d2b54e73b1c02e2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.2/emu198x-oric-atmos-x86_64-apple-darwin.tar.gz"
      sha256 "e2a23beb357a4b8c3152062d2886f5fd55e5d59c797f7c9fb682995958e61478"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.2/emu198x-oric-atmos-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "685268db3a9ddc3ca88f200d06eeffcb0940880aa38e9a22a49ee6a3d3b50db7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.2/emu198x-oric-atmos-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "72d9c3067532d3f006409765be3c98f3982ee93086129f993fa3ab03180c555e"
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

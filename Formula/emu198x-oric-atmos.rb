class Emu198xOricAtmos < Formula
  desc "Oric-1 / Atmos headless runner with shell-backed script + MCP parity — 6502 + ULA + VIA-6522 + AY-3-8910"
  homepage "https://emu198x.github.io/"
  version "0.38.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.0/emu198x-oric-atmos-aarch64-apple-darwin.tar.gz"
      sha256 "07bea731043aa1ddf6e648a7820d51a76d1e515c3cf2b5bbf210a6c85eace4e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.0/emu198x-oric-atmos-x86_64-apple-darwin.tar.gz"
      sha256 "a3c8fcfa6d1310c60b75b672b374c74cc9dd832616d7d33a14562e904a4cc27e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.0/emu198x-oric-atmos-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b77a6d55bff7b49af040cbac0d60a492b9b0ea6accf2289ee6608cc9e41540db"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.0/emu198x-oric-atmos-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a81704daa0f9bb71434dd6b975db8f54f49b0710d836182fef9a46cbdbe26ade"
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

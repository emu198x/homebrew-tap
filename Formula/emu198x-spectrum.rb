class Emu198xSpectrum < Formula
  desc "Sinclair ZX Spectrum emulator with native UI, scripts and MCP"
  homepage "https://emu198x.github.io/"
  version "0.46.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-spectrum-aarch64-apple-darwin.tar.gz"
      sha256 "db50e995c9c55d80e7af2ce2ec9474b6421c836efed0f5a153c8fac725eb2fc6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-spectrum-x86_64-apple-darwin.tar.gz"
      sha256 "453d7e2827692f44c9a328495d9c5b3597f8d94dc945909f94369d03e77386e2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-spectrum-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3e7f314bbc1128f68e53e4a061e1892868648defb881eb8fdd71233d992b6f47"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-spectrum-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6b66f301a1290ff1e05eb324d77f730bc0a65db31beba69fe0f58b4c2aefc2b3"
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
      bin.install "emu198x-spectrum"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-spectrum"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-spectrum"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-spectrum"
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

class Emu198xSpectrum < Formula
  desc "Sinclair ZX Spectrum emulator with native UI, scripts and MCP"
  homepage "https://emu198x.github.io/"
  version "0.34.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-spectrum-aarch64-apple-darwin.tar.gz"
      sha256 "efef703c2f8de1518426ef7776db0d1b1b1dc795a855ab2e1894bff1cc7f99ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-spectrum-x86_64-apple-darwin.tar.gz"
      sha256 "75a13e5995c6ed7f5ad873eaedcf84a69d749d1349f8ff2777436960b7a3e040"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-spectrum-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4a31ac660928b94ac6659b485eca1ff8a9df683e4684b19a05820c287bbda9e8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-spectrum-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "48e7ea8e7f2a7e8ae8990bf222d082d0dc131db29fc9eb574180d56c379b336d"
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

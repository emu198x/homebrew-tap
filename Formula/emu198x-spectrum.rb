class Emu198xSpectrum < Formula
  desc "Sinclair ZX Spectrum emulator with native UI, scripts and MCP"
  homepage "https://emu198x.github.io/"
  version "0.38.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-spectrum-aarch64-apple-darwin.tar.gz"
      sha256 "bbdf4998c2531cf0d06fdcc194d81cd9b8f002fbb2571fb65599e6e8751c3533"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-spectrum-x86_64-apple-darwin.tar.gz"
      sha256 "1c7127e5e05a521342e60b5c7ae47daaf9417755619093f343bd3b7cd9677b0e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-spectrum-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f18bf8c781914a0ddc13caf097b19c0f9336082d728c3efd16fa619b6e32987a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-spectrum-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c7fe81fa340afa543e107a09883f1f02f36857e6a353ba118871f401349509de"
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

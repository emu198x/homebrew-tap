class Emu198xSpectrum < Formula
  desc "Sinclair ZX Spectrum emulator with native UI, scripts and MCP"
  homepage "https://emu198x.github.io/"
  version "0.37.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-spectrum-aarch64-apple-darwin.tar.gz"
      sha256 "9b5eaba6f5e44de8b62882287e9ce4178426867d01ac5ebd27de963475644db6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-spectrum-x86_64-apple-darwin.tar.gz"
      sha256 "8f3b8626cc8a69614e643ebe6c3990e0c16eef94cdf0233eb5bc2b8e8f0093ac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-spectrum-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d2405a8678616487505b688c94b81271e9872a256443ec317bae49281b03620c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-spectrum-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "638954ffa79396fb8164d6b2099bae6bcb480daa480ea9dd563d1c791e61e0f7"
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

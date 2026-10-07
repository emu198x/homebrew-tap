class Emu198xSpectrum < Formula
  desc "Sinclair ZX Spectrum emulator with native UI, scripts and MCP"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-spectrum-aarch64-apple-darwin.tar.gz"
      sha256 "c069f3eaf68d6742973376afd18d13b78a0822b059853c18e5c1182acac2601a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-spectrum-x86_64-apple-darwin.tar.gz"
      sha256 "cbfe331a5c382ee6dea8a3416d68875b9c2c618e161106b40b24a1adb347acca"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-spectrum-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "21c1069bfdfd8891928169e57ddb39e9b9f3d4f0ccc427730b0903d3c7e8a702"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-spectrum-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "64e8cf77fa1956269b172070a57ccf8505964149516e31f490af081c65842268"
    end
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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

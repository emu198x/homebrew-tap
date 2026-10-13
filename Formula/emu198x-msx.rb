class Emu198xMsx < Formula
  desc "MSX1 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + AY-3-8910 + 8255 PPI"
  homepage "https://emu198x.github.io/"
  version "0.32.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-msx-aarch64-apple-darwin.tar.gz"
      sha256 "46643fad4ded96241e7f76b7c74545368ddb38045577bfbb0887a3d04e634695"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-msx-x86_64-apple-darwin.tar.gz"
      sha256 "e51614ffd45aca03107f9076029244105c8f311ca9cf26f15f262d2dbbacf809"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-msx-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dd486d46ad9e470772b4b933e47d9659a2086fdc275553a771d5982bd1104bd0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-msx-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b629d076f824a9c5ecc67623386391688da3e54eb0688a0f859f5578609755d8"
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
      bin.install "emu198x-msx"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-msx"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-msx"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-msx"
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

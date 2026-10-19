class Emu198xMsx < Formula
  desc "MSX1 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + AY-3-8910 + 8255 PPI"
  homepage "https://emu198x.github.io/"
  version "0.38.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.2/emu198x-msx-aarch64-apple-darwin.tar.gz"
      sha256 "90c2d38cc9830ef3faf10a09a87117a4b3714a905d700e885394bd3629e04c60"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.2/emu198x-msx-x86_64-apple-darwin.tar.gz"
      sha256 "1db4b48fb858a452e427235e9c29c8fdd795b920ad62e4317ee3f2898fef8fe5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.2/emu198x-msx-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "86cdc318124211da6b50a42de47f4802b399bae7bc79f29d0308640e7fd6429c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.2/emu198x-msx-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9079156010a5599a2d835a6ca3fbf40aeda62bcb38e70f21bcb2f03fa1bddac2"
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

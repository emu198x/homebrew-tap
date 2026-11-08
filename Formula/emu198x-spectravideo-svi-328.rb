class Emu198xSpectravideoSvi328 < Formula
  desc "Spectravideo SVI-328 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + AY-3-8910 + 8255 PPI"
  homepage "https://emu198x.github.io/"
  version "0.48.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-spectravideo-svi-328-aarch64-apple-darwin.tar.gz"
      sha256 "c9e6d1eacebdb621ebbe1b84de5f4ae17a00c6ab9a98a65aae147a976ff64461"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-spectravideo-svi-328-x86_64-apple-darwin.tar.gz"
      sha256 "13e111170a239a047acb27c298cde0bde86e61940cb6a668e829455966d3b8e0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-spectravideo-svi-328-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d4edd29054df62e8a288b1d04e95aa9f691397db6173fcf677d9d3783421baa0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-spectravideo-svi-328-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "72a68208bc74e6a2012590291191ac4fdb0ed5a34d0dbc933853b452ccd3707d"
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
      bin.install "emu198x-spectravideo-svi-328"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-spectravideo-svi-328"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-spectravideo-svi-328"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-spectravideo-svi-328"
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

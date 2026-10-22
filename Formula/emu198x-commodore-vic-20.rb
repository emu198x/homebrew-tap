class Emu198xCommodoreVic20 < Formula
  desc "Commodore VIC-20 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.44.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-commodore-vic-20-aarch64-apple-darwin.tar.gz"
      sha256 "e34c236bbb77e8176f49421b3edad52c607ca0a3ed2278c3802e9479c6b175ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-commodore-vic-20-x86_64-apple-darwin.tar.gz"
      sha256 "51225796e9858a91453e7823e2d0b192307d623a213d1e8016713ba4acef03bd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-commodore-vic-20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d3f28f56f060f2d392268f863df440dc47e35783baff49db60dd674af58d1851"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-commodore-vic-20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e94ba20fe937b928bbdcebd51930e8ddbbd289f6442fb7a4b1451cb04175e4f1"
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
      bin.install "emu198x-commodore-vic-20"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-commodore-vic-20"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-commodore-vic-20"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-commodore-vic-20"
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

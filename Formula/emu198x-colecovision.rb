class Emu198xColecovision < Formula
  desc "ColecoVision headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489AN"
  homepage "https://emu198x.github.io/"
  version "0.38.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-colecovision-aarch64-apple-darwin.tar.gz"
      sha256 "98001835fa37d1704291806a19c83436d5e7a757581cadf56b35084f6051773d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-colecovision-x86_64-apple-darwin.tar.gz"
      sha256 "cc7385c1d2fa05a30944f3aed0b9444708cb7bbd40cb83933826db7dee54bb56"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-colecovision-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c78e18203eaeefda1100626df6cd9b9a203208d9f4fd4afdd53c4d2195d80d9e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-colecovision-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fbcbed65e597df9cfa8f272cb36d3f4cb345f91406807c2f8cade67465f0bd22"
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
      bin.install "emu198x-colecovision"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-colecovision"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-colecovision"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-colecovision"
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

class Emu198xColecovision < Formula
  desc "ColecoVision headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489AN"
  homepage "https://emu198x.github.io/"
  version "0.39.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.1/emu198x-colecovision-aarch64-apple-darwin.tar.gz"
      sha256 "aed43a5cde5829d16753e743a005a72d8e2d6f880a46a1b412b3095f19fd49ab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.1/emu198x-colecovision-x86_64-apple-darwin.tar.gz"
      sha256 "65922343d4079627c0ce9d5e5a382e86e29622f140b46f6e647e236222b13730"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.1/emu198x-colecovision-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f72075380c2bb41f1182288e98b9db3e5b44880a1de12db3be1b0b23f21cf6cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.1/emu198x-colecovision-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "62fb91247c2cff1919e909bac9740569df1268ee30fe4c8b4d3f35d528eabbba"
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

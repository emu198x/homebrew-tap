class Emu198xColecovision < Formula
  desc "ColecoVision headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489AN"
  homepage "https://emu198x.github.io/"
  version "0.38.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-colecovision-aarch64-apple-darwin.tar.gz"
      sha256 "5e879f8de0e7ca87b66ce7df7ba4900aca96f6ee788d84a47399725ae1b5e779"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-colecovision-x86_64-apple-darwin.tar.gz"
      sha256 "215a2ae9409824d2fca635baf17e7b95ea14f64a147c0c42ea22d862498882b1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-colecovision-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c4e9d7dd52a1d9d31e46e3a65fcc74ae5c763605009935417cf0294c8ff94549"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-colecovision-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d7bbea4dbc2844f4e2c1f3136403001718200a667d073194c4fc073388fb9b3b"
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

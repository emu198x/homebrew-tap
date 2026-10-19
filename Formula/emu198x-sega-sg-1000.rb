class Emu198xSegaSg1000 < Formula
  desc "Sega SG-1000 / SC-3000 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489A"
  homepage "https://emu198x.github.io/"
  version "0.38.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-sega-sg-1000-aarch64-apple-darwin.tar.gz"
      sha256 "7a27e980bbd5d2df5374ae02005b64d79e5f936153727cf46e022760e25eef00"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-sega-sg-1000-x86_64-apple-darwin.tar.gz"
      sha256 "a0cf32f6281c00c7ea3542408c9fbc406324eb13569982f987cfb9447617ad73"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-sega-sg-1000-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7ac123dfeccaf5d0d5c9052f520d50bcffd3f29d2bbfba85636562234ae496e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-sega-sg-1000-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "421e57c4b212d71d1cea6befd18677798dee917d7fe5d94164cc1bb4987a2bd5"
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
      bin.install "emu198x-sega-sg-1000"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sega-sg-1000"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sega-sg-1000"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sega-sg-1000"
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

class Emu198xMsx < Formula
  desc "MSX1 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + AY-3-8910 + 8255 PPI"
  homepage "https://emu198x.github.io/"
  version "0.39.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-msx-aarch64-apple-darwin.tar.gz"
      sha256 "b11e6fad2c94de55468fcfb60a029081a36037381e05efaf591d91a18ab09318"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-msx-x86_64-apple-darwin.tar.gz"
      sha256 "213810062b175052aaa288b6105fc4a79f6475a1271198ddf0502645e6ce4371"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-msx-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e132d22d5abc5b8b432bd9d5d782e0b8ce8a0f986e078600d402f8d5d51aba94"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-msx-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c948ff7f31ef43ef3e3573186d8a92e6952941b7399767573222456453c60c4f"
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

class Emu198xAppleIi < Formula
  desc "Original Apple II emulator with shared native UI, scripts and MCP"
  homepage "https://emu198x.github.io/"
  version "0.48.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-apple-ii-aarch64-apple-darwin.tar.gz"
      sha256 "26296e138bbed2972763767d26e7ee4e44411e9dbfebb3367bf24f2d4ffba9a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-apple-ii-x86_64-apple-darwin.tar.gz"
      sha256 "2d0b707906a2d046ebace59712b69f69d4d3e06a09c65c7530bcd7089105d935"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-apple-ii-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "76a56d381f0b5023b0247719e83651182d0096fbec19cd1e9f739970922670e3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.3/emu198x-apple-ii-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "297c2304f7af7a2e67508f6c65542e16eaf7fd5feaeff20801a4285fb2b4e6bb"
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
      bin.install "emu198x-apple-ii"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-apple-ii"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-apple-ii"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-apple-ii"
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

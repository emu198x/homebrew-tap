class Emu198xSegaSg1000 < Formula
  desc "Sega SG-1000 / SC-3000 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489A"
  homepage "https://emu198x.github.io/"
  version "0.39.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-sega-sg-1000-aarch64-apple-darwin.tar.gz"
      sha256 "b55f4cb50e625e9893bbba3706a41bb8a0720127b5750aed7e71db1f4b445405"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-sega-sg-1000-x86_64-apple-darwin.tar.gz"
      sha256 "0dbfaf6a97d6c7c0817fa3461293e9122c978262136eb5b81a90471097f05cac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-sega-sg-1000-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5de0a07c08d97d24beeb05efa9ef8c0b180b4c077417bf149ec9b401413c34d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-sega-sg-1000-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a4e4fb1b873e09ef87be72c6c2ee18e809194514591387e2d9fe10dd2206322e"
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

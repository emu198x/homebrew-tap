class Emu198xSnes < Formula
  desc "Super NES / Super Famicom headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.48.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-snes-aarch64-apple-darwin.tar.gz"
      sha256 "c5953abb5d342a3b24136006b8cf8743662417330918a82288090deb418c30aa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-snes-x86_64-apple-darwin.tar.gz"
      sha256 "97e7c4447c646fba4a2531a5e3de032e7c71ddbf5cf943dfd1d850925f995968"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-snes-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2b10cc412ee975f4e9cdfd9bb522c6ffa9d57996c3abae26b2fd4c52cfc1f485"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-snes-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e20fd44637e9ee783726f1e50789ead5dd616d58ca8d49743ee66fa6725b03f8"
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
      bin.install "emu198x-snes"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-snes"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-snes"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-snes"
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

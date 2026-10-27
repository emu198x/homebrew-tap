class Emu198xJupiterAce < Formula
  desc "Jupiter Ace headless runner with shell-backed script + MCP parity — Z80A + 8 KB Forth ROM"
  homepage "https://emu198x.github.io/"
  version "0.45.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-jupiter-ace-aarch64-apple-darwin.tar.gz"
      sha256 "5e9b134d66a1040bf558c4407ebc1e096585945b3281d5891e39efbaa941dfdf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-jupiter-ace-x86_64-apple-darwin.tar.gz"
      sha256 "612ad104216d513a0b0233a22e56aca0c8c63b2ace5211a9f76e4ae05376a8be"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-jupiter-ace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ce3d342328346f78817a92d2ffcfede2b7ff94d859e2b53f81ff50d7a7d3771a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-jupiter-ace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "83d8eb2d3035293bf235d6ad1611f271baf21285609a25b8d1108ac6f12e4bac"
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
      bin.install "emu198x-jupiter-ace"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-jupiter-ace"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-jupiter-ace"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-jupiter-ace"
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

class Emu198xC64 < Formula
  desc "Native Commodore 64 verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.48.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-c64-aarch64-apple-darwin.tar.gz"
      sha256 "2ae7e7e71c7b7a5d9f627b615546b3b6e4fdb266187d6f2cc040453b02475095"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-c64-x86_64-apple-darwin.tar.gz"
      sha256 "2fc72a43b6a4d25dab66cf76d407fde0b484690daf0ea025ed1806cc46835c26"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-c64-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a0bafc599dca38c77fd203c369dd5e8850cf66760d7b0c74996c7b49f0ae5190"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-c64-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "118c168af7def2545e9eaea5ad70debe7b3973ec7810d0909b425d2e7fc67869"
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
      bin.install "emu198x-c64"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-c64"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-c64"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-c64"
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

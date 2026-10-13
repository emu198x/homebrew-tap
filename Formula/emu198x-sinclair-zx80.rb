class Emu198xSinclairZx80 < Formula
  desc "Sinclair ZX80 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.32.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-sinclair-zx80-aarch64-apple-darwin.tar.gz"
      sha256 "5cb54c674b77cd4f9702f7485fcaf249228485404f63bde75e900f55bbf2c0ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-sinclair-zx80-x86_64-apple-darwin.tar.gz"
      sha256 "00b8cc1a31d9e687de26e3d3d0721dd21454aee674d9dbe6de95be96450dd105"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-sinclair-zx80-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a13eedbf2b54d89f628b6427d5b9ad102daa9ccdb463094a98eb5753d4350dd2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.5/emu198x-sinclair-zx80-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "12c96d6f5324c0615c0cf7440656e87b4c2e0e83ce5f2708ca790da289c117ff"
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
      bin.install "emu198x-sinclair-zx80"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sinclair-zx80"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sinclair-zx80"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sinclair-zx80"
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

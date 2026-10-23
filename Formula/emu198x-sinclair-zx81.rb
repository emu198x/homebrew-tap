class Emu198xSinclairZx81 < Formula
  desc "Sinclair ZX81 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.44.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.2/emu198x-sinclair-zx81-aarch64-apple-darwin.tar.gz"
      sha256 "200e4553aaa6b55bfbe8240c704e8748a6aaac74670edbd6d73cae7996c3f7f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.2/emu198x-sinclair-zx81-x86_64-apple-darwin.tar.gz"
      sha256 "ae9e30d7e92fcd9d75d891eb308c6c0fe1285c272fd082fd5e914fcddf1f8f14"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.2/emu198x-sinclair-zx81-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "30fe403e36fed1b9c5b75b8ff267f55d6ca852b92bee5b07323de21456c652a6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.2/emu198x-sinclair-zx81-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "acd6f5185e677816b54fd6f761b07b048779c4d0d5b642359de4848cf99b4da1"
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
      bin.install "emu198x-sinclair-zx81"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sinclair-zx81"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sinclair-zx81"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sinclair-zx81"
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

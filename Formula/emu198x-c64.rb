class Emu198xC64 < Formula
  desc "Native Commodore 64 verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.48.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-c64-aarch64-apple-darwin.tar.gz"
      sha256 "60f53db3149a24a2ee72bc5662445581e42a4ebd841bee787f0690a99086c268"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-c64-x86_64-apple-darwin.tar.gz"
      sha256 "074fac2649b3aa4170a7ee6dbf4bbf9f9d53e339cf62ddebaaf85a0b415392e4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-c64-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "94e2319708dba0b4b654a892efc6a33ace43ac7e232427f913fd0e2533393e1a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.4/emu198x-c64-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7b4cab56d8c3c98d05859ea65e1657acbf54d8de84dc019282b94581de2820b8"
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

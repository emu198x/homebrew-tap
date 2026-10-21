class Emu198xSinclairZx81 < Formula
  desc "Sinclair ZX81 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.43.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.43.0/emu198x-sinclair-zx81-aarch64-apple-darwin.tar.gz"
      sha256 "8b31dff5398c888758d2b494fb94adace72136a795555e4f8423ffbbda9ee7e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.43.0/emu198x-sinclair-zx81-x86_64-apple-darwin.tar.gz"
      sha256 "4b8790108fbb0b234b3446299907d0c3471e989f2f077fe35494d950962e1345"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.43.0/emu198x-sinclair-zx81-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "69c30b6f8ecefb5bcda1d62860a20083b0e2da8c3d3e6ac666fad2862a52c434"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.43.0/emu198x-sinclair-zx81-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0e53186b16fdd1fd773c6d2cb8e020d08e00cc8f48224d1ee04feaa354efa17a"
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

class Emu198xSinclairZx81 < Formula
  desc "Sinclair ZX81 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.35.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.0/emu198x-sinclair-zx81-aarch64-apple-darwin.tar.gz"
      sha256 "4a3dc6405956bcf3eeffc983ac8af52e70385075610cab3315c40b1f482679b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.0/emu198x-sinclair-zx81-x86_64-apple-darwin.tar.gz"
      sha256 "37e30836354fdfe9779635e9547c69563f69bfeefc06c316b6cbbfbcc9cccea5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.0/emu198x-sinclair-zx81-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b3169d72ffa0d7a808a9e2be0974b14a044998b24dfcf3ffd07d5bb2da9541da"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.0/emu198x-sinclair-zx81-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1685091a6ad688137c6f1c72e569cadd8314d26d024d7a9c63dc9ccc138b2e1b"
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

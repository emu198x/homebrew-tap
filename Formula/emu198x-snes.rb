class Emu198xSnes < Formula
  desc "Super NES / Super Famicom headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.45.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-snes-aarch64-apple-darwin.tar.gz"
      sha256 "027d7521a67c3d7a79fbaac6aaad775090dd878f7fbbf7639a991a4d39e0da76"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-snes-x86_64-apple-darwin.tar.gz"
      sha256 "0e36354bc2ece35c1f7d30bd555f4b8f6e8c6afe208e8e0529ad46c5619c1655"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-snes-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "23a684e5503a889c54a12760e9aca626f23146b81beaad3fbc67d02c1685f1e4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-snes-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a191dab0c178562a377279b9beaea35debe31fa29bc21422213ee2c43608841d"
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

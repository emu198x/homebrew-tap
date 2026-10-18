class Emu198xDragon < Formula
  desc "Native Dragon 32/64 verifier with interactive UI, headless harness, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.37.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-dragon-aarch64-apple-darwin.tar.gz"
      sha256 "89fcad930e65cc5a386ae6e912332150963b416e4d34e8d38a263674a4096bcb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-dragon-x86_64-apple-darwin.tar.gz"
      sha256 "b2feab35e612db1d56683c7d77ab9cd028d6455d795be60982b56a4167fc2379"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-dragon-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "37c1f86e67d117e5a4582d0f3f719faa72fea74aefd522a7723d22198a14b9dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.37.0/emu198x-dragon-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3715a209721ffe6771bcd54b6ddf962ae0441402cbe80bc066df74b149834040"
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
      bin.install "emu198x-dragon"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-dragon"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-dragon"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-dragon"
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

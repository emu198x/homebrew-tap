class Emu198xSnes < Formula
  desc "Super NES / Super Famicom headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.46.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-snes-aarch64-apple-darwin.tar.gz"
      sha256 "fba5c537369a8c915799cceb714270cbb36ea976dbabe83b25149f06534d9f92"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-snes-x86_64-apple-darwin.tar.gz"
      sha256 "fc700a5a62ff849e5939c350645af7b12de6dc9d79368f5d9bdd7c45137b2f04"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-snes-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "22fcf476e0a39245fec7ee2ae6ef024fec7a7fc0c83215610229171f50dbbe1d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-snes-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b224e3e98997d65334e6086aad788675b2d2c123bc8271da80ab40f04ce2d2fe"
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

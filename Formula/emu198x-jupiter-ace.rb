class Emu198xJupiterAce < Formula
  desc "Jupiter Ace headless runner with shell-backed script + MCP parity — Z80A + 8 KB Forth ROM"
  homepage "https://emu198x.github.io/"
  version "0.35.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-jupiter-ace-aarch64-apple-darwin.tar.gz"
      sha256 "007e1e0243eb54422a33dc0b8005dc541466fc85e53193499940c878f0b1c1aa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-jupiter-ace-x86_64-apple-darwin.tar.gz"
      sha256 "bee05fc577b783c8f31fe9171efb1a2a756e5c05daaf2aa405be749321e9e29c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-jupiter-ace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "18f570d94e0323ce865ce5c5c76b25ccb0f8d84898eff9daa724f9f3fef5192a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.3/emu198x-jupiter-ace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "15875ea107cc91a6f357725b3dc246c2afcbdab9f724150975c006bb5602940a"
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

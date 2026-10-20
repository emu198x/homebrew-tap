class Emu198xSinclairZx81 < Formula
  desc "Sinclair ZX81 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.39.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-sinclair-zx81-aarch64-apple-darwin.tar.gz"
      sha256 "28d02bd2e67959e1778062dabb2f4dcd3bd1f676b5789f4b16269e7201a535a3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-sinclair-zx81-x86_64-apple-darwin.tar.gz"
      sha256 "509c2d14808137c2e7d5dd336717d1ac1988698b7abc800a54e1ce8873c19e80"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-sinclair-zx81-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cdacb3eb87247278a22e02e47293d2ef37290441e4ac0ac0349565c450fca2d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.39.0/emu198x-sinclair-zx81-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "49fbeabc2b8b8010b94d4e077ae44a5d26329ae19dd56e8e1917b2e579cd811c"
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

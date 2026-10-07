class Emu198xJupiterAce < Formula
  desc "Jupiter Ace headless runner with shell-backed script + MCP parity — Z80A + 8 KB Forth ROM"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-jupiter-ace-aarch64-apple-darwin.tar.gz"
      sha256 "fe811543c06bc84f85cca83c33806429197f24f9edd7cabfb2f817dea4403f71"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-jupiter-ace-x86_64-apple-darwin.tar.gz"
      sha256 "bab5e308f707ca195a5d99b084ca51c297a60a33b6016b9df7a9be3e9e795b40"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-jupiter-ace-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d014f673f38e79c9dd8918f67956da3ff1fcfaa34d6d0e8441a0e10bb75d4d9b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-jupiter-ace-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a613206012aa48568ccaad6e957315193169c98cdbe7d2baf073c379bcb77252"
    end
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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

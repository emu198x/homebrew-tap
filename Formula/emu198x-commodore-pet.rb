class Emu198xCommodorePet < Formula
  desc "Commodore PET headless runner with shell-backed script + MCP parity — 6502 + 6845 CRTC + 6520 + 6522"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-commodore-pet-aarch64-apple-darwin.tar.gz"
      sha256 "3a634cb1167c524b5e27be8b781eaccfc616e9f60ed30606c53113a3c1d2ebed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-commodore-pet-x86_64-apple-darwin.tar.gz"
      sha256 "8943e1109f9562878823da28d79da0786e0346cb38f9092d979e7f5aea2b2d1c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-commodore-pet-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "be8f1541c49d7af13d4f8799eb173643aab9fa950665a4a08d01ccec9a64c22b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-commodore-pet-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0c80f5bfb85731795cb5af962a4a6913f97e2c2fbbc5bf5fd28ba5946f62bb12"
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
      bin.install "emu198x-commodore-pet"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-commodore-pet"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-commodore-pet"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-commodore-pet"
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

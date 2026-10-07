class Emu198xC64 < Formula
  desc "Native Commodore 64 verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-c64-aarch64-apple-darwin.tar.gz"
      sha256 "0c9a0b33a0acdd5ed06cfe30081fbe59488a7dfaf006ec43a765be17678b4e81"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-c64-x86_64-apple-darwin.tar.gz"
      sha256 "e1467e1170baa84b57d279c934526ff9ccc82f158789be31cdcada23ab6d9341"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-c64-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "08bf9bdd3da11efab174d0a6df0ae416301aedc2170056f1bcebdfa4a0c620c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-c64-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "87a6df154b5a507f1ec60cc314880d879e54596c002791eea352fb2c7165955d"
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

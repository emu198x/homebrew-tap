class Emu198xCommodorePet < Formula
  desc "Commodore PET headless runner with shell-backed script + MCP parity — 6502 + 6845 CRTC + 6520 + 6522"
  homepage "https://emu198x.github.io/"
  version "0.40.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-commodore-pet-aarch64-apple-darwin.tar.gz"
      sha256 "a7fd3ce275a29690b638fa0c47112f47b76ccde84a31671980f86cd81c963f97"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-commodore-pet-x86_64-apple-darwin.tar.gz"
      sha256 "8651abfc7f49f52e7857d556dac9651dfe251826971d66a093459697feb67c6c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-commodore-pet-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "79a2d8f4d92d76e040b88dc69656954f704a3525b6be522ac2090fcd8c78938c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-commodore-pet-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "def7444ef178b5549cd46916ae9260fe436d82ceadb7503559a1a99352d9e040"
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

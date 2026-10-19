class Emu198xCommodorePet < Formula
  desc "Commodore PET headless runner with shell-backed script + MCP parity — 6502 + 6845 CRTC + 6520 + 6522"
  homepage "https://emu198x.github.io/"
  version "0.38.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-commodore-pet-aarch64-apple-darwin.tar.gz"
      sha256 "7ea590859d79e6e7ece6746c3604a6bd6ba75f3f1f668bdcaaf8eeaa415d2a4f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-commodore-pet-x86_64-apple-darwin.tar.gz"
      sha256 "7edab118f9bf0ddb1974701ec3f6774c19339f10c20bd4ca0d94097ed1acefaa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-commodore-pet-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "da17034681b29b35ffdb1c99e4c8e04f1eb489c616ccfc25b4972bfe756bf87d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.1/emu198x-commodore-pet-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "17252db9f54e0b1d5aede265fe6b0be14a407a6ca7dea8e386e6a02e55fa4074"
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

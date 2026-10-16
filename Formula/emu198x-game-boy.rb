class Emu198xGameBoy < Formula
  desc "Native Game Boy verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.35.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-game-boy-aarch64-apple-darwin.tar.gz"
      sha256 "7ac58765c43b58fa3b7a5c057d0dca2ee762c91ff2bb6f5f93d10cf483af65e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-game-boy-x86_64-apple-darwin.tar.gz"
      sha256 "83b8ae6972fc79359e3a25046455b61576e7506ed5a0c058b666bd640d5f8b1a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-game-boy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "28800ce073e3a9e7376216baebed7e099ecb9f569760f0742c986068b8fc7bea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-game-boy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bba8f6ffbcb424d5696e71dc33d61cbd889cbcc8ee8a7b9cbae0d7c277b1ce9d"
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
      bin.install "emu198x-game-boy"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-game-boy"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-game-boy"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-game-boy"
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

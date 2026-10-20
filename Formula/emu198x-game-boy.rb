class Emu198xGameBoy < Formula
  desc "Native Game Boy verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.41.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.41.0/emu198x-game-boy-aarch64-apple-darwin.tar.gz"
      sha256 "e50cb1976d1bdaf2d41a4e39d24fb4d3ed68699104b0f8b2f590fb4321332539"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.41.0/emu198x-game-boy-x86_64-apple-darwin.tar.gz"
      sha256 "df1e31373873f6cf6bfe67d622300e1ce67baa233934416d3fb754550a7e5b58"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.41.0/emu198x-game-boy-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e65e61d1f82b0c02c4e86c9903db05f3e398cfe59cb5fde53c50641ce1963c47"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.41.0/emu198x-game-boy-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cd714aeac1161ef2e7150a8c98e392a56c062ffc2f65823863632a32adb7ff71"
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

class Emu198xC64 < Formula
  desc "Native Commodore 64 verifier with interactive UI, headless script, and MCP modes"
  homepage "https://emu198x.github.io/"
  version "0.33.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.33.0/emu198x-c64-aarch64-apple-darwin.tar.gz"
      sha256 "718ee9ece3b09bb73cd67bff7de7e5caecd97502d64d848406ef2b6689ad683e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.33.0/emu198x-c64-x86_64-apple-darwin.tar.gz"
      sha256 "7fd5afe43983d940974ccf1c4e7f35e6351fc1ef4983571a5d7b1555bbb9205a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.33.0/emu198x-c64-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4a37555d92a6da3b0f6f87cbfddbf1a168692139f5d430f556cee434ed1f0086"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.33.0/emu198x-c64-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8f7d6b3684d63af55b7ec995d0f5c371f03e547cce492800f8bfc01a9c387816"
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

class Emu198xAtari7800 < Formula
  desc "Atari 7800 ProSystem headless runner with shell-backed script + MCP parity — 6502C Sally + MARIA + RIOT"
  homepage "https://emu198x.github.io/"
  version "0.32.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-atari-7800-aarch64-apple-darwin.tar.gz"
      sha256 "7b91bd9efa2bfbc6d995e7a62c71dcc54ea3aca8cd063280b4ce19da4454c44f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-atari-7800-x86_64-apple-darwin.tar.gz"
      sha256 "fab75771ab317f31a24a9fefaf974076d8493bf569c8e3201d773cce5c7eb1cd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-atari-7800-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "58a5de6fece230f2be76743d77f7ccaa16d9a583d64275d6baa118738e9afc50"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-atari-7800-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e139ddf9be6680e8a3d821de2f8a910ea5f00b394694ae5afc5e11923dae5941"
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
      bin.install "emu198x-atari-7800"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-7800"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-7800"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-7800"
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

class Emu198xAtari2600 < Formula
  desc "Atari 2600 (VCS) headless runner with shell-backed script + MCP parity — 6507 + TIA + RIOT"
  homepage "https://emu198x.github.io/"
  version "0.38.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-atari-2600-aarch64-apple-darwin.tar.gz"
      sha256 "a31ae96a07a04777923c98313a55bc9fe94b3cdd250500297e97f00475ce5f47"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-atari-2600-x86_64-apple-darwin.tar.gz"
      sha256 "405ebfe290331ee11ea4d16245f7b6cc101878899097e0367bfc52a0ef42c07e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-atari-2600-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "276f5f5ad8155d969fbbe277d39796c9b51fddb0f038673b16891846d1025bc1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-atari-2600-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7dd9996f6549c898e2b0f2279195a4a86b80782a570211339aa689e6fe5f90e9"
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
      bin.install "emu198x-atari-2600"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-2600"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-2600"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-2600"
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

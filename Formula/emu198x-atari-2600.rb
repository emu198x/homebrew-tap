class Emu198xAtari2600 < Formula
  desc "Atari 2600 (VCS) headless runner with shell-backed script + MCP parity — 6507 + TIA + RIOT"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-2600-aarch64-apple-darwin.tar.gz"
      sha256 "0b99fe4baf8db43c50aaea882496985b7bf1038f535fdd7f84cf19e3ab3afabb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-2600-x86_64-apple-darwin.tar.gz"
      sha256 "ba5403481632993262986ddac8c4159069ce59fa8f76957e2874ee4ea12b0a63"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-2600-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "41d1aebcae5446d50148d1e8b71b11b82bfeaaddb5febdbab93bfd36078e1b78"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-atari-2600-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a096db1aac014d548c1adf1eed8404d59f1f9fd41c28b903ac750cc51200296f"
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

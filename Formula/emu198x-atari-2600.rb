class Emu198xAtari2600 < Formula
  desc "Atari 2600 (VCS) headless runner with shell-backed script + MCP parity — 6507 + TIA + RIOT"
  homepage "https://emu198x.github.io/"
  version "0.35.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.4/emu198x-atari-2600-aarch64-apple-darwin.tar.gz"
      sha256 "10530a814b54cb337e151a7b3f202e8f5840a66f9856c633d8fc507df8279d57"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.4/emu198x-atari-2600-x86_64-apple-darwin.tar.gz"
      sha256 "e8d9425dc154f0eb1655a93e0ac220ed282f390d2fb080d24cc3a4b282d62aae"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.4/emu198x-atari-2600-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "72fa464ce9db9e643b60ec22a4701836ed3bb3264d3c7f5b90ac504a14ae8ff5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.4/emu198x-atari-2600-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "157578e95c62fd19acb3595a3e79118191debf32ffa8f2d5194457ab43df0d21"
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

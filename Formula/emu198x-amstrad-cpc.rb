class Emu198xAmstradCpc < Formula
  desc "Amstrad CPC464 runner with shell-backed UI, script and MCP parity — Z80 + Gate Array + HD6845S + AY-3-8912"
  homepage "https://emu198x.github.io/"
  version "0.42.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-amstrad-cpc-aarch64-apple-darwin.tar.gz"
      sha256 "a25aad948114469c23c330cfbc6e5f3a7eacd5a0eb6f2f1a0bea1c1fa9d32386"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-amstrad-cpc-x86_64-apple-darwin.tar.gz"
      sha256 "a5701327f9e2140be278e44698289a948a1defe4240a2e3f865058d176b30050"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-amstrad-cpc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ea0a98b9893b80abeb3ef15e5d0a09a738f402f7552dfd762944ee955bba09b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-amstrad-cpc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "797dc8bc204e0a7678810f180b791f94a27c4ef0fb0a9e6534938b9c70897328"
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
      bin.install "emu198x-amstrad-cpc"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-amstrad-cpc"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-amstrad-cpc"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-amstrad-cpc"
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

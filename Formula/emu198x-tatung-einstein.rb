class Emu198xTatungEinstein < Formula
  desc "Tatung Einstein TC-01 headless runner with shell-backed script + MCP parity — Z80 + TMS9929A + AY-3-8910"
  homepage "https://emu198x.github.io/"
  version "0.46.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.1/emu198x-tatung-einstein-aarch64-apple-darwin.tar.gz"
      sha256 "91bbf6d0e292a05ba063a91e272aab53827f21b3a9136a02b849f192b01582f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.1/emu198x-tatung-einstein-x86_64-apple-darwin.tar.gz"
      sha256 "9fe7ebd39c3dcc063b0118b1f0b409c128c3336ae8c8ff70c0f58969cb9e3b69"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.1/emu198x-tatung-einstein-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "38674a08b66e9762ceab3a88530458c97c9795bc2ce570ae1b85d5a87b738012"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.1/emu198x-tatung-einstein-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a955683d39e19e8431b97b2769a8e9361fc835b3f0f711ae8fe751803e04bf8f"
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
      bin.install "emu198x-tatung-einstein"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-tatung-einstein"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-tatung-einstein"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-tatung-einstein"
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

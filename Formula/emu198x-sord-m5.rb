class Emu198xSordM5 < Formula
  desc "Sord M5 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489A"
  homepage "https://emu198x.github.io/"
  version "0.40.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-sord-m5-aarch64-apple-darwin.tar.gz"
      sha256 "89c1094098d02e4feb8253a554f2711e3d6b57724f4df87985006256825594fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-sord-m5-x86_64-apple-darwin.tar.gz"
      sha256 "b15b2e1003f2f732e74345589a1bcab8b11be2354c8043556b0f1a0743b6d312"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-sord-m5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f3080846d5b607ad3d3dbc810c34383b390ba024b645c941b75271cc986f0fcf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-sord-m5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5292a3f474113a208ac5a546e982a54420e53d958214d9a93853de6a95852326"
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
      bin.install "emu198x-sord-m5"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sord-m5"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sord-m5"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sord-m5"
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

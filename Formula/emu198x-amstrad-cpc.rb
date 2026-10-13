class Emu198xAmstradCpc < Formula
  desc "Amstrad CPC464 runner with shell-backed UI, script and MCP parity — Z80 + Gate Array + HD6845S + AY-3-8912"
  homepage "https://emu198x.github.io/"
  version "0.32.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-amstrad-cpc-aarch64-apple-darwin.tar.gz"
      sha256 "6052e4c5460ec7b398560b3ffeedfc851a39500cc1af1eb940d206e1fe623587"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-amstrad-cpc-x86_64-apple-darwin.tar.gz"
      sha256 "43a0ee8b365af3abcd3c59532f041e1c0a5d181b6708851f859231c5e8118934"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-amstrad-cpc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b0a793142485eef9d3acc59a54d2c6c703818d0f1ba6422c4da0df41400c8cc1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.2/emu198x-amstrad-cpc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0c986b315fc2a3b4597647dc230aa564ce15f1776e097a3846ee9dc9a4086a57"
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

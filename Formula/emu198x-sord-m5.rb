class Emu198xSordM5 < Formula
  desc "Sord M5 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489A"
  homepage "https://emu198x.github.io/"
  version "0.46.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.1/emu198x-sord-m5-aarch64-apple-darwin.tar.gz"
      sha256 "d6cd65c0d39e2af7c08fc4852acbcbe47277e292968e3cc27630e9d910f52892"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.1/emu198x-sord-m5-x86_64-apple-darwin.tar.gz"
      sha256 "0eb1b695ccaf1e41a0642cb43d33151af375c6624008430510ef5973f979e098"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.1/emu198x-sord-m5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "47fd7e028622241e8a3c53af2426a3b2d3b0dca72892de7303b7d1a5474e2455"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.1/emu198x-sord-m5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "60bc3c5062376477861a89208ea61f5c2c772f1c3b8fb207f181731e47f0e3fb"
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

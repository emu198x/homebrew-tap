class Emu198xAcornBbcMicro < Formula
  desc "BBC Micro Model B headless runner with shell-backed script + MCP parity — 6502 + 6845 + Video ULA + 2x VIA + SN76489"
  homepage "https://emu198x.github.io/"
  version "0.42.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-acorn-bbc-micro-aarch64-apple-darwin.tar.gz"
      sha256 "308934a78928b3535fc59e2d96327821bd37b8153aa743fd17ca52dc62479d65"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-acorn-bbc-micro-x86_64-apple-darwin.tar.gz"
      sha256 "8a1ecb8c9f111b4863681a1570e680548963d69460cca6e3f9de67f56c41145b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-acorn-bbc-micro-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5a71d501a21834e3e997689bcebe38a5094ebc64c6d093b3ac2681c73dc9bdd6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.42.0/emu198x-acorn-bbc-micro-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "90f346df2f07ccb7175db9d70334be3776434eb8f46d4879188bc2a70db63fce"
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
      bin.install "emu198x-acorn-bbc-micro"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-bbc-micro"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-acorn-bbc-micro"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-bbc-micro"
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

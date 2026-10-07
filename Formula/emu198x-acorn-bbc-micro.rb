class Emu198xAcornBbcMicro < Formula
  desc "BBC Micro Model B headless runner with shell-backed script + MCP parity — 6502 + 6845 + Video ULA + 2x VIA + SN76489"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-acorn-bbc-micro-aarch64-apple-darwin.tar.gz"
      sha256 "ac46c3d0124668b095769feb8bb84044c0ccecb4e241747dcdb83cbdcfaaf9b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-acorn-bbc-micro-x86_64-apple-darwin.tar.gz"
      sha256 "5e94f91cae20148a2482751192bca69a858ae64019a77c7453a28c98c11f52fd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-acorn-bbc-micro-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "08a428131fa736b9a06a56b5ea9223b4264e011fc57d3740183d08168e7d231b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-acorn-bbc-micro-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "993a8ede4b4e0b7194093ce7c67c4498f3c855e794609f55d1a4a02cac900815"
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

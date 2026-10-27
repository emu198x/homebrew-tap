class Emu198xSegaMegaDrive < Formula
  desc "Sega Mega Drive / Genesis headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.45.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-sega-mega-drive-aarch64-apple-darwin.tar.gz"
      sha256 "835221311ce0a8c8c61a37577e11b4bd7a03c6b5d54a5646b9d8b35ff033969a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-sega-mega-drive-x86_64-apple-darwin.tar.gz"
      sha256 "7e1c96387770db8a2d1095892902af6d2d46d96d1f8c38a23c446ac8830a11e9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-sega-mega-drive-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5ace2628c4c179fc26d009d0581ead08db858ea9e94ac1e7147c4c7d47e0ed80"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.45.1/emu198x-sega-mega-drive-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e72b1350b5b4e008c43ec1c71dc71bbc59f0125740def0afcbef537fe9e65312"
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
      bin.install "emu198x-sega-mega-drive"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sega-mega-drive"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sega-mega-drive"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sega-mega-drive"
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

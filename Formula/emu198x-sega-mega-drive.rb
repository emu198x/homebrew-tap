class Emu198xSegaMegaDrive < Formula
  desc "Sega Mega Drive / Genesis headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.46.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-sega-mega-drive-aarch64-apple-darwin.tar.gz"
      sha256 "dd452475d7a77c9bea93539715c5fb2b8c6238b7008ad7c81cec88beb0135c21"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-sega-mega-drive-x86_64-apple-darwin.tar.gz"
      sha256 "76e9db721ba63cc3407717f4821ab6a7bfda1ac5f81e665d06104a09e42b41af"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-sega-mega-drive-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "314c534222f8c769d44a01aa33a6fa45c74f50e8fe3aa0842f431d5110755013"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.46.2/emu198x-sega-mega-drive-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3b58605a0f6dc61d41b9532b1ea3e378383bd80ef07fc33ea6167eebdf7dd62a"
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

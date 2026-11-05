class Emu198xAtariSt < Formula
  desc "Atari ST headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.48.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-atari-st-aarch64-apple-darwin.tar.gz"
      sha256 "72bd5ed35abefc43fae86f460b99ea21ed8a63723f9b0eb23fd12fb4bef45e0a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-atari-st-x86_64-apple-darwin.tar.gz"
      sha256 "3d2d1584aa6f3d315cfdb121a252f0b193060b3175ecdcc7c1c6296c30e19763"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-atari-st-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1a3378863d75683935ed8eb812573e40f9a8cf4d5c4fd002b5e04735d5041ea7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-atari-st-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1643c7aba9db1f9dac1bef7e451965bb51e6017e4311cff09a2eb2ad4f06bfec"
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
      bin.install "emu198x-atari-st"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-st"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-st"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-st"
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

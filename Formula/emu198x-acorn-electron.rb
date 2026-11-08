class Emu198xAcornElectron < Formula
  desc "Acorn Electron headless runner with shell-backed script + MCP parity — 6502A + custom ULA"
  homepage "https://emu198x.github.io/"
  version "0.48.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-acorn-electron-aarch64-apple-darwin.tar.gz"
      sha256 "38f31483ab83d61be133ace68d5d1a0203eab1a5b10bf675ceca90f909e8dcd1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-acorn-electron-x86_64-apple-darwin.tar.gz"
      sha256 "c7afcbbf205af922c4dbca9002db80c6bdddaddeabc51c2d439ea1235f42840f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-acorn-electron-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fb81a95a1ce887b877bd82777fc2305ec1de96f846cf8afcbc290b50a7c0ce36"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.5/emu198x-acorn-electron-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c049cc0912f5c4ba7b0bdf4acd4159e1b60ee530941c4ac9097a35c6122f7131"
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
      bin.install "emu198x-acorn-electron"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-electron"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-acorn-electron"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-electron"
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

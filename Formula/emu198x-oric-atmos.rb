class Emu198xOricAtmos < Formula
  desc "Oric-1 / Atmos headless runner with shell-backed script + MCP parity — 6502 + ULA + VIA-6522 + AY-3-8910"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-oric-atmos-aarch64-apple-darwin.tar.gz"
      sha256 "15e4c811cde25399dae55cf79d2491b51aec94f364cd073458e8fe78d49bc5b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-oric-atmos-x86_64-apple-darwin.tar.gz"
      sha256 "bce83dd558e5aa14348a82a2cdb66ed0dbecfa39e5aef2de6c1c3c7753fa3258"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-oric-atmos-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "901c32ef19511d73890018aa9aae248b881bf61424e74420255d6eafb6725d41"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-oric-atmos-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "226c2181f424040efe93d395e06d4c5423d8dd7d14c0b7af7eaa1f7f574861f0"
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
      bin.install "emu198x-oric-atmos"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-oric-atmos"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-oric-atmos"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-oric-atmos"
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

class Emu198xSnkNeoGeo < Formula
  desc "SNK Neo Geo AES headless runner with shell-backed script + MCP parity — 68000 + Z80 + LSPC2 + YM2610"
  homepage "https://emu198x.github.io/"
  version "0.47.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.47.0/emu198x-snk-neo-geo-aarch64-apple-darwin.tar.gz"
      sha256 "5353393dbb5e7c6697087f4c0b54721b9882fb456036cd7aa10fded30f00ba23"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.47.0/emu198x-snk-neo-geo-x86_64-apple-darwin.tar.gz"
      sha256 "e661f885ee4f438ed1563a0401513608cb016998ce6254153231fa8c87e5fd8b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.47.0/emu198x-snk-neo-geo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2e9efc2a688d02a0393646f6cde84c6ec98c0995cf7157f20fd98915f91f3796"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.47.0/emu198x-snk-neo-geo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a0a2a8fe38a4666ceaa85d22098a681e88053591de00e4a0ccaca488f9477063"
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
      bin.install "emu198x-snk-neo-geo"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-snk-neo-geo"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-snk-neo-geo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-snk-neo-geo"
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

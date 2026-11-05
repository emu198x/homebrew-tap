class Emu198xSnkNeoGeo < Formula
  desc "SNK Neo Geo AES headless runner with shell-backed script + MCP parity — 68000 + Z80 + LSPC2 + YM2610"
  homepage "https://emu198x.github.io/"
  version "0.48.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-snk-neo-geo-aarch64-apple-darwin.tar.gz"
      sha256 "8beec62c53c272becab7fc84a2b27941e437d6b97248f60788ab6444c86c31b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-snk-neo-geo-x86_64-apple-darwin.tar.gz"
      sha256 "dbfefc44a8737ae1b6d95d4edfcf8ec495516785c95e03fbe72876daf32f57dd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-snk-neo-geo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "02a8f068df8c318b62120745062518b3118249ded60375aaf8651cf72058a501"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-snk-neo-geo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b3f7c6fba1d804224f2f7320cd438d6c46af7ae1b9e6c41873ddd07aee30ed48"
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

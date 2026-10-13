class Emu198xAmstradCpc < Formula
  desc "Amstrad CPC464 runner with shell-backed UI, script and MCP parity — Z80 + Gate Array + HD6845S + AY-3-8912"
  homepage "https://emu198x.github.io/"
  version "0.32.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-amstrad-cpc-aarch64-apple-darwin.tar.gz"
      sha256 "dcff18556fb21aa0cc6812b0f12587f5fd66e0637cfa2336d227d6f56e7373e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-amstrad-cpc-x86_64-apple-darwin.tar.gz"
      sha256 "8778f34d2a5eac9c4d972c14adefa8482ab93332e57356ab94740816e5ce54db"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-amstrad-cpc-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "948a8cf3db948a4a64afbf2915ce60b4eeb19107fbdbc6853edd561b3fb021df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-amstrad-cpc-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "30a96e8258fd0da68f9b8613ab3ce7b21b41ad6ae695066938186e3a7384e952"
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
      bin.install "emu198x-amstrad-cpc"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-amstrad-cpc"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-amstrad-cpc"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-amstrad-cpc"
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

class Emu198xSpectravideoSvi328 < Formula
  desc "Spectravideo SVI-328 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + AY-3-8910 + 8255 PPI"
  homepage "https://emu198x.github.io/"
  version "0.35.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.5/emu198x-spectravideo-svi-328-aarch64-apple-darwin.tar.gz"
      sha256 "048be70682a916082548a321df471f76855637558cd7296ab9b36ea036e8e592"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.5/emu198x-spectravideo-svi-328-x86_64-apple-darwin.tar.gz"
      sha256 "dbbd6603fe711eb5fc855be613ad618b3a5ea724bef27c3d592aa6250c05baf5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.5/emu198x-spectravideo-svi-328-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8ad01d408af3bbb36177e1b67505d898afc7bbfa87149c821708aa8e1dd46dbd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.5/emu198x-spectravideo-svi-328-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9ef1778c73c6a7e77e1d160d68a24d2b1ed3ae241263dc9695702ec22a109db4"
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
      bin.install "emu198x-spectravideo-svi-328"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-spectravideo-svi-328"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-spectravideo-svi-328"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-spectravideo-svi-328"
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

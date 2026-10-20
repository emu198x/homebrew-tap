class Emu198xSegaMasterSystem < Formula
  desc "Sega Master System headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.40.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-sega-master-system-aarch64-apple-darwin.tar.gz"
      sha256 "5944064b97a215a28fbc684896e56771cd50c511a1c731a6bed339de8262712b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-sega-master-system-x86_64-apple-darwin.tar.gz"
      sha256 "123ac1545b3ab0482493cb488798b06f67474b428a1f22db8d04674ece8e61ea"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-sega-master-system-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d96621c446cde54bc27a3155aef14c1eedc1988db087c5eea4e1dba3b537db55"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.40.0/emu198x-sega-master-system-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "745aa76862fccafdfc40ac54300a415f923bce582936cc672ebd28fcf7e76424"
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
      bin.install "emu198x-sega-master-system"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sega-master-system"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sega-master-system"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sega-master-system"
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

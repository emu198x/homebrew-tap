class Emu198xSegaMasterSystem < Formula
  desc "Sega Master System headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.34.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-sega-master-system-aarch64-apple-darwin.tar.gz"
      sha256 "d7a0f8dcd9332df4c00e3dbc9b109dc9f01a66a0f6a69956bc73931cda843866"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-sega-master-system-x86_64-apple-darwin.tar.gz"
      sha256 "b0d0f1dfcc690c410cf6224c00b7327fab7fd3a4c5bfb75391650dd79a82f0ef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-sega-master-system-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c94feff683174a98d2bf7c274508f5300b627a647a13575ff775253ae4b67c3a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.2/emu198x-sega-master-system-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "15758985755c3e0ed31e0859b50bb1405b36cf05abbc84b1f93b650d869a0652"
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

class Emu198xSegaMasterSystem < Formula
  desc "Sega Master System headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.44.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.0/emu198x-sega-master-system-aarch64-apple-darwin.tar.gz"
      sha256 "b5a4f3a7067d88bac1b93fa31658a9db904151360833351ca643c3c0e024efb8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.0/emu198x-sega-master-system-x86_64-apple-darwin.tar.gz"
      sha256 "686ff0e0a9e8382c6a7bbb5fa39b72155ca07c0ad8f5e4c48ce4868932173869"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.0/emu198x-sega-master-system-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d45136af327876f17942e9bc498a41442224c952e79de2818304d1d8017bfa2f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.0/emu198x-sega-master-system-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "700b27f61d1129def03a6f8333a2e0ed524b71788ecf505de41ae46dc1034dcd"
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

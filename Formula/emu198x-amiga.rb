class Emu198xAmiga < Formula
  desc "Native Amiga verifier with interactive UI, headless script, and MCP debugging modes"
  homepage "https://emu198x.github.io/"
  version "0.32.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-amiga-aarch64-apple-darwin.tar.gz"
      sha256 "092582fc39b53a600d0512ecc9877badf216f8a7fbb17e2971141bcd9b1acb7a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-amiga-x86_64-apple-darwin.tar.gz"
      sha256 "6e09617fe3a3ec46859bb0668a83e6f197af15cbb92b6bbebde82ce58e2e99cf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-amiga-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0d3ba3bd248ef473c5d5fcbafa1281d9a9a2239f38ad7d05cd2a671f0228d656"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-amiga-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "91fb0385e78e4c7db0bcde62daaf5476292fa5cc071fe799fdbd5fae992ff36e"
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
      bin.install "emu198x-amiga"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-amiga"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-amiga"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-amiga"
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

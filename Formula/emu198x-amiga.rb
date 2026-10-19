class Emu198xAmiga < Formula
  desc "Native Amiga verifier with interactive UI, headless script, and MCP debugging modes"
  homepage "https://emu198x.github.io/"
  version "0.38.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-amiga-aarch64-apple-darwin.tar.gz"
      sha256 "a5eb3ae36deb15244a4c387bdeb510d6231a4bf18e2ea77e68b242b7fe9b0e98"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-amiga-x86_64-apple-darwin.tar.gz"
      sha256 "073eaa59faf9152e6937066b4563c2289e6c99d66493932c327d3e5968251bd7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-amiga-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e159bcc7c2aaf6982035e576b057fc6f22684d7d623a1f545f53eeb4f2dc733a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-amiga-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e835a0f6b1e98a06c5916f1f0404f8579b8363c44234d9762b3f7877f1afa435"
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

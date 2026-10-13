class Emu198xMattelAquarius < Formula
  desc "Mattel Aquarius headless runner with shell-backed script + MCP parity — Z80 + memory-mapped char display"
  homepage "https://emu198x.github.io/"
  version "0.32.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-mattel-aquarius-aarch64-apple-darwin.tar.gz"
      sha256 "acbcccba3575298e6f6c874759f2e2adb3934fcde9a4c880bfbe929d325edc83"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-mattel-aquarius-x86_64-apple-darwin.tar.gz"
      sha256 "ed15c8eb2aa46546cba0de7c29384927dd4d71bdf44209a5c0ddd904a7181130"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-mattel-aquarius-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "08226965a8c93f96c03601c25f39cd364a90b14ef8653e9d09864b0a0bf813c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.32.3/emu198x-mattel-aquarius-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5a8e4c508994c8cde90d6b3dab844d1b2c9bf8ad944a22a887e8b0386658e8d7"
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
      bin.install "emu198x-mattel-aquarius"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-mattel-aquarius"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-mattel-aquarius"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-mattel-aquarius"
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

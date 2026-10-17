class Emu198xAtari800xl < Formula
  desc "Atari 800XL headless runner with shell-backed script + MCP parity — 6502C Sally + ANTIC + GTIA + POKEY + PIA-6520"
  homepage "https://emu198x.github.io/"
  version "0.35.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.5/emu198x-atari-800xl-aarch64-apple-darwin.tar.gz"
      sha256 "d83c88ab8ea3ca4e8ac35b0c9223aca1e821abd586d8981b8fda92b191afa55b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.5/emu198x-atari-800xl-x86_64-apple-darwin.tar.gz"
      sha256 "aa6703a45aa44daa4a88ea0fd5f87028eeb405f0733e11ce76e932bcdfebc33c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.5/emu198x-atari-800xl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "59e7b0085e154ee6058ea1a6dac310bbd1a2ff7897dc31c83b82fecd5c113795"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.5/emu198x-atari-800xl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8ccf99c26ba4a40ec611b00285ba55465816d5dd3ea6b008805292b19f6707d5"
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
      bin.install "emu198x-atari-800xl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-atari-800xl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-atari-800xl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-atari-800xl"
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

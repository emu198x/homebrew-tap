class Emu198xTatungEinstein < Formula
  desc "Tatung Einstein TC-01 headless runner with shell-backed script + MCP parity — Z80 + TMS9929A + AY-3-8910"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-tatung-einstein-aarch64-apple-darwin.tar.gz"
      sha256 "153256835a0e866702ac80eef7124cffcb2d590dcef162467e594b3f0f114d58"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-tatung-einstein-x86_64-apple-darwin.tar.gz"
      sha256 "3a82e67dffb9ad144dbe1291cb148fbd548e26bc3825204ee54f6575f07a07c3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-tatung-einstein-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9358c0d5d47e5b33ef40ae499452fc98d1e2f2891e9ebdb5b7efd5de0b0cc7c9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-tatung-einstein-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c1d5b621731a7457d775fbe69ea0c083d1d058575fdaed43d5115df384979c46"
    end
  end
  license "GPL-2.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "emu198x-tatung-einstein"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-tatung-einstein"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-tatung-einstein"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-tatung-einstein"
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

class Emu198xSinclairZx80 < Formula
  desc "Sinclair ZX80 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.43.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.43.0/emu198x-sinclair-zx80-aarch64-apple-darwin.tar.gz"
      sha256 "86c0a5fdf1f8e8a1a57358b980abf6a926fe5af4d93d6068f26bf428f7b92542"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.43.0/emu198x-sinclair-zx80-x86_64-apple-darwin.tar.gz"
      sha256 "fc05971066355874fe0a0978aef76cc5ee5aa95c35cbc86d9a633a6f57243cbe"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.43.0/emu198x-sinclair-zx80-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5fa84adb0bf874eb90558ad80c16831345936e9be5d644aa6773bcd2d44851f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.43.0/emu198x-sinclair-zx80-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "81e56ec05f72f23ea1d6fe7965bc3c8c3f6ed8696da116dac450fe45054c3b59"
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
      bin.install "emu198x-sinclair-zx80"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sinclair-zx80"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sinclair-zx80"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sinclair-zx80"
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

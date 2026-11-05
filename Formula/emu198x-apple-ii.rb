class Emu198xAppleIi < Formula
  desc "Original Apple II emulator with shared native UI, scripts and MCP"
  homepage "https://emu198x.github.io/"
  version "0.48.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-apple-ii-aarch64-apple-darwin.tar.gz"
      sha256 "dd64a6e41e7a246e516e269da05fc745962d10b6386d5ff0b36b036e64d73397"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-apple-ii-x86_64-apple-darwin.tar.gz"
      sha256 "18b150ff8ecc475461d6f71181f95f657dba37c92be2ef55b5b20af8b225de03"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-apple-ii-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3ffcbcfb91d9e406cee9fc7df13341adc2fbcea12ad97605b6892a0eba9799f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.48.2/emu198x-apple-ii-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4ff245882a0cdc1ae87f20c8179b3a22618d7ddd02e91ac148de85b79f7d292b"
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
      bin.install "emu198x-apple-ii"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-apple-ii"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-apple-ii"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-apple-ii"
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

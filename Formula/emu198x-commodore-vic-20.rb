class Emu198xCommodoreVic20 < Formula
  desc "Commodore VIC-20 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.29.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-commodore-vic-20-aarch64-apple-darwin.tar.gz"
      sha256 "9b98e5b8e95616c8031558e19c095902d48f80ed05a2b4b3e9a543defa460e34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-commodore-vic-20-x86_64-apple-darwin.tar.gz"
      sha256 "e5cef33ab36c1ffe4e38fc358c8dde032b8ad73d9c6e8b07246210c477f3960b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-commodore-vic-20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aee4aada0f507e6a9d3c517ebea25585a96a06e314be0d6ca274a9e3a0864ddb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.29.0/emu198x-commodore-vic-20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2d37bb2e913b7ed009bba3db38e320bfb9379d4e80c8e4b3df867301ba6b80f3"
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
      bin.install "emu198x-commodore-vic-20"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-commodore-vic-20"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-commodore-vic-20"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-commodore-vic-20"
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

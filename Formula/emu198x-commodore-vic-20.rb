class Emu198xCommodoreVic20 < Formula
  desc "Commodore VIC-20 headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.35.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.0/emu198x-commodore-vic-20-aarch64-apple-darwin.tar.gz"
      sha256 "1158d3c7d9557c24801af748863d3fb1f48f2ffbb26cee44ae67aa3f9bad049c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.0/emu198x-commodore-vic-20-x86_64-apple-darwin.tar.gz"
      sha256 "2e8a7b4dd5fcebbe6f590b82b33b369dd039564e0a76827b70d871b2fe57ed3b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.0/emu198x-commodore-vic-20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "424741744c75795364ce9e98fd51f65bf07938a8c680a59ddb6a1261b951087d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.0/emu198x-commodore-vic-20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7e4b0341495461b4118143f0f27ef3ae349db7afcb8a06ab4ac46980d70f51ab"
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

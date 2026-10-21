class Emu198xAcornAtom < Formula
  desc "Acorn Atom headless runner with shell-backed script + MCP parity — 6502 + 24 KB combined ROM"
  homepage "https://emu198x.github.io/"
  version "0.44.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.0/emu198x-acorn-atom-aarch64-apple-darwin.tar.gz"
      sha256 "5debfd6484b1682b3c1ef7d89f22038cd7ab47173d36702080626655db412e76"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.0/emu198x-acorn-atom-x86_64-apple-darwin.tar.gz"
      sha256 "21efef1da3fa3e09739924544643fff56f74f2e9af173743b9acb629bdabe7b4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.0/emu198x-acorn-atom-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3c3f72468b2100469d6821c3e0fab180618e83a1fd734b1ce0d6cb5d15f2e1cd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.0/emu198x-acorn-atom-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cacfafd4d86417f9ec6b84089beb50963281bdfa766a12ce4dfe573186dc9fff"
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
      bin.install "emu198x-acorn-atom"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-atom"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-acorn-atom"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-atom"
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

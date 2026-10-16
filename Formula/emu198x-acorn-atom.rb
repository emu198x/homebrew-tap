class Emu198xAcornAtom < Formula
  desc "Acorn Atom headless runner with shell-backed script + MCP parity — 6502 + 24 KB combined ROM"
  homepage "https://emu198x.github.io/"
  version "0.35.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-acorn-atom-aarch64-apple-darwin.tar.gz"
      sha256 "5ce41ea322e9290e3875515d1553f1fdd54afb50d0e30008c59ce1b24cb289d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-acorn-atom-x86_64-apple-darwin.tar.gz"
      sha256 "8d3920eb2fd0459fc52851ced8fedb7c4575f629aab6cf3c95593e554ccf8323"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-acorn-atom-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "28da2d894cdcb0d9205a3bcf35dc2aa33b11d0f583b6b441f8555ae21ae994e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-acorn-atom-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3fa97aa6ac0502dd79d93692d761e47c4d8bd1f20bc14da7f226c33841a2d324"
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

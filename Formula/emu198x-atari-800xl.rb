class Emu198xAtari800xl < Formula
  desc "Atari 800XL headless runner with shell-backed script + MCP parity — 6502C Sally + ANTIC + GTIA + POKEY + PIA-6520"
  homepage "https://emu198x.github.io/"
  version "0.34.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-atari-800xl-aarch64-apple-darwin.tar.gz"
      sha256 "f39b14ded9ff08e31fc57227c231c8251d24608a4986fd039c12e1895cb7f306"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-atari-800xl-x86_64-apple-darwin.tar.gz"
      sha256 "22237c0858a8d6af48ca6e75952115dbbb93e92c97e819516c6c115a51134dbc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-atari-800xl-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c678f4862ff9f799e06d726b7be497399adf0e069d77ed52686d9c66b43b5142"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.34.1/emu198x-atari-800xl-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b71767b67eaf5d25dfd04033c9b77a64eef8fee6ab35dd0294e2ca5ff5eaf313"
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

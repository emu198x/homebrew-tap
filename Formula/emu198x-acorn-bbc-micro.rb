class Emu198xAcornBbcMicro < Formula
  desc "BBC Micro Model B headless runner with shell-backed script + MCP parity — 6502 + 6845 + Video ULA + 2x VIA + SN76489"
  homepage "https://emu198x.github.io/"
  version "0.44.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-acorn-bbc-micro-aarch64-apple-darwin.tar.gz"
      sha256 "9d6144f9f6823912ebfe0c5a32ba8d575b5ed6e01c07ff1ea7e16bc487a8feb6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-acorn-bbc-micro-x86_64-apple-darwin.tar.gz"
      sha256 "2dfc2e1fa57b7d9b1d3e70f8a019ee441bbb633cb9cb2ced5ff32f8d136b765c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-acorn-bbc-micro-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "926bf53ce390877b6e5c1b4c3572e9c13b470a5858b843ce60c3246a9747c2f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.1/emu198x-acorn-bbc-micro-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "468dcea962731d280f891ca3dd456ac37f822a73e7fd349d1f25918fe2d71c11"
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
      bin.install "emu198x-acorn-bbc-micro"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-bbc-micro"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-acorn-bbc-micro"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-acorn-bbc-micro"
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

class Emu198xSegaSg1000 < Formula
  desc "Sega SG-1000 / SC-3000 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489A"
  homepage "https://emu198x.github.io/"
  version "0.44.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.2/emu198x-sega-sg-1000-aarch64-apple-darwin.tar.gz"
      sha256 "67ca20383174ed9f92335f6384acff5e4248360940cd161dcd10252a7c331b2a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.2/emu198x-sega-sg-1000-x86_64-apple-darwin.tar.gz"
      sha256 "8dec001dd603bfbc0d332a095cdeddf9245f524683ef64dc7f66f64925be7089"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.2/emu198x-sega-sg-1000-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "18f05050e61ccd2fde83b0089ee6c348a641faffa286870a2d85eb3aed340c4d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.2/emu198x-sega-sg-1000-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6b43101fb396c0fbcf7ec0b59976383659c70815538e578a8e27d5ac91aab8ab"
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
      bin.install "emu198x-sega-sg-1000"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sega-sg-1000"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sega-sg-1000"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sega-sg-1000"
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

class Emu198xSpectravideoSvi328 < Formula
  desc "Spectravideo SVI-328 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + AY-3-8910 + 8255 PPI"
  homepage "https://emu198x.github.io/"
  version "0.35.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-spectravideo-svi-328-aarch64-apple-darwin.tar.gz"
      sha256 "821cece52a17505dec6b46d3888af4e9c7e0d160befdcd9d27d3b80e3c05dafb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-spectravideo-svi-328-x86_64-apple-darwin.tar.gz"
      sha256 "9b612e127b076dd3d4a0a95e227575c9011621207ff94d800a3d33ee74aa6bd8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-spectravideo-svi-328-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ff8edb98c8ed9dc93e294fddb825948de1036adcd1727feea0dd26a2814bfd9a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-spectravideo-svi-328-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1375742a8b4bc74303edc04dbac245d4244be1f6792b129ed843b140406c8869"
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
      bin.install "emu198x-spectravideo-svi-328"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-spectravideo-svi-328"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-spectravideo-svi-328"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-spectravideo-svi-328"
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

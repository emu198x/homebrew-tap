class Emu198xSpectravideoSvi328 < Formula
  desc "Spectravideo SVI-328 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + AY-3-8910 + 8255 PPI"
  homepage "https://emu198x.github.io/"
  version "0.44.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.2/emu198x-spectravideo-svi-328-aarch64-apple-darwin.tar.gz"
      sha256 "5db20be7a49f68e68d55519df32a0d9ec3e41334bf71a59d60c930cadaa8a0bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.2/emu198x-spectravideo-svi-328-x86_64-apple-darwin.tar.gz"
      sha256 "b23b554f9bc952762a509021c2f9b3290c79e35daf9d4bfbf5b3bb6e8961eda4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.2/emu198x-spectravideo-svi-328-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ed56c27d7b3527c3cf8fdb6495b93de1a38961b7c0a79a0a91b27106ffa7d757"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.44.2/emu198x-spectravideo-svi-328-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fc4a60ccc24cbfe33b6750952d4c0604c5c0db7a1589094e39e0668c1d082287"
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

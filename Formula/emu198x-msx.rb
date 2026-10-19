class Emu198xMsx < Formula
  desc "MSX1 headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + AY-3-8910 + 8255 PPI"
  homepage "https://emu198x.github.io/"
  version "0.38.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-msx-aarch64-apple-darwin.tar.gz"
      sha256 "304bea23623d38973d21f8a388a2f6d7bd98b3744fd5ef28743fc09ef08ece1d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-msx-x86_64-apple-darwin.tar.gz"
      sha256 "6fa0eb77d7f3cf5d57ebd1a9e0c21401165777644b5d8f1b8049dc5d2866b3f1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-msx-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "33e6c1102a0156ed3782f320ac538e6f286e32cd4438f6cddc656e2bac8b54d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-msx-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2a846969c67e2d628f80c5ac0ab2d444dab72a8e49b320f8bddb73d0845cf70d"
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
      bin.install "emu198x-msx"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-msx"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-msx"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-msx"
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

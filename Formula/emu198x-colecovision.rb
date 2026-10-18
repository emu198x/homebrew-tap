class Emu198xColecovision < Formula
  desc "ColecoVision headless runner with shell-backed script + MCP parity — Z80 + TMS9918A + SN76489AN"
  homepage "https://emu198x.github.io/"
  version "0.38.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.0/emu198x-colecovision-aarch64-apple-darwin.tar.gz"
      sha256 "8e37bda822e8989b4fee44fefa552c46774d69b1c55a814f69cd5d765dec5b80"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.0/emu198x-colecovision-x86_64-apple-darwin.tar.gz"
      sha256 "0dac3f4629716c14c135231e7290a137dfa2bda56eb8e1295aff2a16f0004e86"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.0/emu198x-colecovision-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "11b57db608918c66c3671269448c9b9a474033d1dca06b584908af4d47dccee9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.0/emu198x-colecovision-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cb89fe0e26c69c76bbc3e4dc02b8ea36643317ba6fb870b435bb3bc5a2c56fd3"
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
      bin.install "emu198x-colecovision"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-colecovision"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-colecovision"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-colecovision"
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

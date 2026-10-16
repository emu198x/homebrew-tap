class Emu198xSegaMasterSystem < Formula
  desc "Sega Master System headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.35.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-sega-master-system-aarch64-apple-darwin.tar.gz"
      sha256 "8da08738f4926bc18c553478b9aa9de3221fe9278319b8ba1a97c42941c9e0e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-sega-master-system-x86_64-apple-darwin.tar.gz"
      sha256 "e7b8e9220ef3e2f86eead9d4c4c0fcb98b5b6ad917203b3e83bc8003c2825793"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-sega-master-system-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "03521985b4e8fc563dfb886caaed9b5473604017a4439b857440ad293c36f665"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.35.2/emu198x-sega-master-system-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4a89e02422c7184b4d8e74ca052065aba6a9d6c073a7f66dccd53f658cfed09f"
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
      bin.install "emu198x-sega-master-system"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-sega-master-system"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-sega-master-system"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-sega-master-system"
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

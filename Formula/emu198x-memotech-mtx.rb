class Emu198xMemotechMtx < Formula
  desc "Memotech MTX headless runner with shell-backed script + MCP parity"
  homepage "https://emu198x.github.io/"
  version "0.38.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-memotech-mtx-aarch64-apple-darwin.tar.gz"
      sha256 "305d5c5fee286ed009d908c60445b2755c0a2398714bb5db5c03de227ad79a03"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-memotech-mtx-x86_64-apple-darwin.tar.gz"
      sha256 "a6bbbf18138acc83f5835503ac5fa8b92e2da1f72353936c210291863d818886"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-memotech-mtx-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d741e8a9ac851f0b18d850b4fce21439e8e9ed778cb64cd5a0055bd94c82b74a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/emu198x/emu198x/releases/download/v0.38.3/emu198x-memotech-mtx-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5889ef311eb8dccc53cfccad2b4e8c0cbaaf1a8dd7938a2ab6c9d743a92ee8f8"
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
      bin.install "emu198x-memotech-mtx"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emu198x-memotech-mtx"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emu198x-memotech-mtx"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emu198x-memotech-mtx"
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
